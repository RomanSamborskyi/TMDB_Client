//
//  WellcomeInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfileInteractorProtocol: AnyObject {
    func fetchUserData() async throws
    func compareUserData() async throws
    func logout() async throws
    var sessionId: String { get }
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
    var accountId: Int? { get }
}

class ProfileInteractor {
    //MARK: - property
    weak var presenter: ProfilePresenterProtocol?
    private var keychain = KeyChainManager.instance
    let sessionId: String
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    var accountId: Int?
    
    init(sessionId: String, networkManager: NetworkManager, imageDownloader: ImageDownloader) {
        self.sessionId = sessionId
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
    }
    
}
//MARK: - WellcomeInteractorProtocol
extension ProfileInteractor: ProfileInteractorProtocol {
    func logout() async throws {

        let session = URLSession.shared
        let rawData = [
            "session_id" : sessionId
        ]
        let request = try networkManager.requestFactory(type: rawData, urlData: Authantication.deleteSession(key: Constants.apiKey))
        
        guard let response = try await networkManager.fetchGET(type: DeleteSession.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        //Delete session ID
        keychain.delete(for: Constants.sessionKey)
        //Delete account ID
        keychain.delete(for: Constants.account_id)
        
        try CoreDataManager.instance.deleteUserData()
        
        if response.success {
            print("Session delete")
        } else {
            print("Error of deleting session")
        }
    }
    
    func fetchUserData() async throws {
        guard let user = try CoreDataManager.instance.fetchUserDetails() else { return }
        guard let avatar = UIImage(data: user.uiImageAvatar ?? Data()) else { return }
        self.accountId = user.id ?? 0
        presenter?.didUserFetched(user: user, with: avatar)
    }
    
    func checkUserData() async throws -> (UserProfile,UIImage) {
        
        let userData = try await withThrowingTaskGroup(of: UserProfile.self) { group in
            
            let session = URLSession.shared
            let request = try networkManager.requestFactory(type: NoBody(), urlData: AccountUrl.accDetail(key: Constants.apiKey, sessionId: sessionId))
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
        return (user, avatar)
    }
    
    func compareUserData() async throws {
     
        let fetchedData = try await checkUserData()
        
        guard let avatar = fetchedData.1.pngData() else { return }
        
        let localData = try CoreDataManager.instance.fetchUserDetails()
        
        if fetchedData.0.id != localData?.id || fetchedData.0.name != localData?.name || fetchedData.0.avatar != localData?.avatar {
            try CoreDataManager.instance.deleteUserData()
            
            try CoreDataManager.instance.writeToCoreData(user: fetchedData.0, avatar)
            
            try await fetchUserData()
        }
        print("User data checked ✅")
    }
}
