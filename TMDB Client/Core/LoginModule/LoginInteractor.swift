//
//  LoginInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit


protocol LoginInteractorProtocol: AnyObject {
    func sendLoginRequestwith(login: String, password: String) async throws
    var newSession: Session? { get }
}

class LoginInteractor {
    //MARK: - property
    var newSession: Session? = nil
    let networkManager = NetworkManager()
    let keychain = KeyChainManager.instance
    weak var presenter: LoginPresenterProtocol?
    
}
//MARK: - LoginInteractorProtocol
extension LoginInteractor: LoginInteractorProtocol {
    //Receive access token
    func sendLoginRequestwith(login: String, password: String) async throws {
        
        let requestToken = try await withThrowingTaskGroup(of: TokenResponse.self) { group in

            let session = URLSession.shared
            let request = try networkManager.requestFactory(type: NoBody(), urlData: Authantication.token_request(key: Constants.apiKey))
            
            group.addTask { [request] in
                guard let data = try await self.networkManager.fetchGET(type: TokenResponse.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return data
            }
            
            var returnedToken: String = ""
            
            for try await token in group {
                returnedToken = token.requestToken
            }
            return returnedToken
        }
        //Validate token with username and password
        let validToken = try await withThrowingTaskGroup(of: TokenResponse.self) { group in
            
            let session = URLSession.shared
            let rawData = User(username: login, password: password, requestToken: requestToken)

            let request = try networkManager.requestFactory(type: rawData, urlData: Authantication.session_with_login(key: Constants.apiKey))
            
            group.addTask { [request, weak self] in
                do {
                    guard let data = try await self?.networkManager.fetchGET(type: TokenResponse.self, session: session, request: request) else {
                        throw AppError.invalidData
                    }
                    return data
                } catch let error as AppError {
                    if error == .badResponse {
                        throw AppError.incorrectUserNameOrPass
                    }
                    throw error
                }
            }
            
            var validToken: TokenResponse? = nil
            for try await token in group {
                validToken = token
            }
            return validToken
        }
        
        if let _ = validToken?.success, let token = validToken?.requestToken {
            self.newSession = try await createSession(with: token)
        }
    }
    //Create session with valid access token and save it in to keychain
    func createSession(with token: String) async throws -> Session? {

        let session = URLSession.shared
        let rawData = [ "request_token" : token ]
        
        let request = try networkManager.requestFactory(type: rawData, urlData: Authantication.newSession(key: Constants.apiKey))
        
        guard let data = try await networkManager.fetchGET(type: Session.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        do {
            try keychain.save(value: data.session_id, for: Constants.sessionKey)
        } catch let error as KeychainError {
            print(error)
        }
        presenter?.didNewSessionStart(with: data)
        print("Session created successfully✅: \(data.success)")
        return data
    }
}
