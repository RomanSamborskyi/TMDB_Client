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
}
