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
           
            guard let url = URL(string: Authantication.token_request(key: Constants.apiKey).url) else {
                throw AppError.badURL
            }
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = Constants.tokenRequestHeader
            
            
            group.addTask { [request] in
                guard let data = try await self.networkManager.fetchGET(type: TokenResponse.self, session: session, request: request) else { throw AppError.invalidData }
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
            guard let  url = URL(string: Authantication.session_with_login(key: Constants.apiKey).url) else {
                throw AppError.badURL
            }
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = Constants.validateTokenWithLoginHeader
            
            let rawData = User(username: login, password: password, requestToken: requestToken)
            
            let bodyData = try JSONEncoder().encode(rawData)
            
            request.httpBody = bodyData
            
            group.addTask { [request] in
                guard let data = try await self.networkManager.fetchGET(type: TokenResponse.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return data
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
        guard let url = URL(string: Authantication.newSession(key: Constants.apiKey).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.createNewSessionHeader
        
        let rawData = [ "request_token" : token ]
        
        let data = try JSONSerialization.data(withJSONObject: rawData)
        
        request.httpBody = data
        
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
