//
//  LoginInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit


protocol LoginInteractorProtocol: AnyObject {
    func sendLoginRequestwith(login: String, password: String) async throws
    func fetchUserData() async throws
    var newSession: Session? { get }
}

class LoginInteractor {
    //MARK: - property
    var newSession: Session? = nil
    private let networkManager = NetworkManager()
    private var imageDownloader = ImageDownloader()
    private let keychain = KeyChainManager.instance
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
    //Fetching user details
    func fetchUserData() async throws {
        
        let userData = try await withThrowingTaskGroup(of: UserProfile.self) { group in

            let session = URLSession.shared
            let request = try networkManager.requestFactory(type: NoBody(), urlData: AccountUrl.accDetail(key: Constants.apiKey, sessionId: newSession?.session_id ?? ""))
            
            group.addTask { [request] in
                guard let data = try await self.networkManager.fetchGET(type: UserProfile.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return data
            }
            var returnedUser: UserProfile?
            
            for try await userInfo in group {
                returnedUser = userInfo
            }
           return returnedUser
        }
        
        
        let userAvatar = try await withThrowingTaskGroup(of: UIImage.self) { group in
            
            var baseURL: URL? = nil
            
            if let userPath = userData?.avatar?.tmdb?.avatarPath {
                baseURL = URL(string: ImageURL.imagePath(path: userPath).url)
            } else if let gravatarPath = userData?.avatar?.gravatar?.hash {
                baseURL = URL(string: ImageURL.gravatarPath(path: gravatarPath).url)
            }
           
            
            guard let url = baseURL else {
                throw AppError.badURL
            }
            
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            group.addTask {
                guard let avatar = try await self.imageDownloader.fetchImage(with: session, request: request) else {
                    throw AppError.invalidData
                }
                return avatar
            }
            
            var avatarImage: UIImage?
            
            for try await userAvatar in group {
                avatarImage = userAvatar
            }
            return avatarImage
        }
        guard let user = userData,
              let avatar = userAvatar else {
            throw AppError.invalidData
        }
        
        do {
            try keychain.save(value: String(user.id ?? 0), for: Constants.account_id)
        } catch let error {
            print("error of saving account ID: \(error.localizedDescription)")
        }
    }
}
