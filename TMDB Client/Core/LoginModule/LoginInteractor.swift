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
    
    var newSession: Session? = nil
    let networkManager = NetworkManager()
    let apiKey: String = "14512c9189d3ba6fe3a1de6324ad576a"
    weak var presenter: LoginPresenterProtocol?
    
}
//MARK: - LoginInteractorProtocol
extension LoginInteractor: LoginInteractorProtocol {
    func sendLoginRequestwith(login: String, password: String) async throws {
        
        let requestToken = try await withThrowingTaskGroup(of: TokenResponse.self) { group in
           
            guard let url = URL(string: Authantication.token_request(key: apiKey).url) else {
                throw AppError.badURL
            }
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = Constatnts.tokenRequestHeader
            
            
            group.addTask { [request] in
                guard let data = try await self.networkManager.fetchGET(type: TokenResponse.self, session: session, request: request) else { throw AppError.invalidData }
                return data
            }
            
            var returnedToken: String = ""
            
            for try await token in group {
                returnedToken = token.request_token
            }
            return returnedToken
        }
        
        let validToken = try await withThrowingTaskGroup(of: TokenResponse.self) { group in
            guard let  url = URL(string: Authantication.session_with_login(key: apiKey).url) else {
                throw AppError.badURL
            }
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = Constatnts.validateTokenWithLoginHeader
            
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
        
        if let success = validToken?.success, let token = validToken?.request_token {
            self.newSession = try await createSession(with: token)
        }
    }
    
    func createSession(with token: String) async throws -> Session? {
        guard let url = URL(string: Authantication.newSession(key: apiKey).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constatnts.createNewSessionHeader
        
        let rawData = [ "request_token" : token ]
        
        let data = try JSONSerialization.data(withJSONObject: rawData)
        
        request.httpBody = data
        
        guard let data = try await networkManager.fetchGET(type: Session.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        presenter?.didNewSessionStart()
        return data
    }
}
