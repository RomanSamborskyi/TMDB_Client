//
//  ListIterator.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


protocol ListsInteratorProtocol: AnyObject {
    func fetchLists() async throws
    func clearList(with id: Int) async throws
    func deleteList(with id: Int) async throws
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
    var sessionId: String { get }
}

class ListsInterator {
    //MARK: - property
    private var keychain = KeyChainManager.instance
    weak var presenter: ListsPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let sessionId: String
    
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionId = sessionId
    }
}
//MARK: - ListsIteratorProtocol
extension ListsInterator: ListsInteratorProtocol {
    func deleteList(with id: Int) async throws {
        
        let session = URLSession.shared

        let request = try networkManager.requestFactory(type: NoBody(), urlData: ListURL.delete(listId: id, apiKey: Constants.apiKey, sessionId: sessionId))
        
        guard let _ = try await networkManager.fetchGET(type: ClearList.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        try await fetchLists()
    }
    func clearList(with id: Int) async throws {
        
        let session = URLSession.shared

        let request = try networkManager.requestFactory(type: NoBody(), urlData: ListURL.clear(listId: id, key: Constants.apiKey, sessionId: sessionId))
        
        guard let _ = try await networkManager.fetchGET(type: ClearList.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        try await fetchLists()
    }
    func fetchLists() async throws {
        
        guard let acoountID = Int(keychain.get(for: Constants.account_id) ?? "") else {
            throw AppError.incorrectAccoutId
        }

        let session = URLSession.shared
        
        let request = try networkManager.requestFactory(type: NoBody(), urlData: AccountUrl.lists(key: Constants.apiKey, accountId: acoountID))
        
        guard let result = try await networkManager.fetchGET(type: ListsResponse.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        if let list = result.results {
            presenter?.didListsFetched(lists: list)
        }
    }
}
