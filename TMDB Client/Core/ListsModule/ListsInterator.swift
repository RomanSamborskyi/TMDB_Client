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
        
        guard let url = URL(string: ListURL.delete(listId: id, apiKey: Constants.apiKey, sessionId: sessionId).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = Constants.deleteListHeader
        
        guard let _ = try await networkManager.fetchGET(type: ClearList.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        try await fetchLists()
    }
    func clearList(with id: Int) async throws {
        
        guard let url = URL(string: ListURL.clear(listId: id, key: Constants.apiKey, sessionId: sessionId).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = Constants.clearListHeader
    
        guard let _ = try await networkManager.fetchGET(type: ClearList.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        try await fetchLists()
    }
    func fetchLists() async throws {
        
        guard let acoountID = Int(keychain.get(for: Constants.account_id) ?? "") else {
            throw AppError.incorrectAccoutId
        }
        
        guard let url = URL(string: AccountUrl.lists(key: Constants.apiKey, accountId: acoountID).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = Constants.listsHeader
        
        guard let result = try await networkManager.fetchGET(type: ListsResponse.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        if let list = result.results {
            presenter?.didListsFetched(lists: list)
        }
    }
}
