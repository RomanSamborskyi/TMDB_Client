//
//  WellcomeInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfileInteractorProtocol: AnyObject {
    func fetchUserData() async throws
    func logout() async throws
}

class ProfileInteractor {
    //MARK: - property
    weak var presenter: ProfilePresenterProtocol?
    private var keychain = KeyChainManager.instance
    let sessionId: String
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    
    init(sessionId: String, networkManager: NetworkManager, imageDownloader: ImageDownloader) {
        self.sessionId = sessionId
        self.networkManager = networkManager
        self.imageDownloader = ImageDownloader()
    }
    
}
//MARK: - WellcomeInteractorProtocol
extension ProfileInteractor: ProfileInteractorProtocol {
    func logout() async throws {
        guard let url = URL(string: Authantication.deleteSession(key: Constants.apiKey).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = Constants.deleteSessionHeader
        
        let rawData: [String: Any] = [
            "session_id" : sessionId
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: rawData)
        } catch {
            print(error.localizedDescription)
        }
        
        guard let response = try await networkManager.fetchGET(type: DeleteSession.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        //Delete session ID
        keychain.delete(for: Constants.sessionKey)
        //Delete account ID
        keychain.delete(for: Constants.account_id)
        
        if response.success {
            print("Session delete")
        } else {
            print("Error of deleting session")
        }
    }
    
    func fetchUserData() async throws {
        
        let userData = try await withThrowingTaskGroup(of: UserProfile.self) { group in
            
            guard let url = URL(string: AccountUrl.accDetail(key: Constants.apiKey, sessionId: sessionId).url) else {
                throw AppError.badURL
            }
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
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
            
            guard let avatarPath = userData?.avatar.tmdb.avatarPath else {
                throw AppError.invalidData
            }
           
            
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(avatarPath)") else {
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
            try keychain.save(value: String(user.id), for: Constants.account_id)
        } catch let error {
            print("error of saving account ID: \(error.localizedDescription)")
        }
        presenter?.didUserFetched(user: user, with: avatar)
    }
}