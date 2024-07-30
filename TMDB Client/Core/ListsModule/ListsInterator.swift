//
//  ListIterator.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


protocol ListsInteratorProtocol: AnyObject {
    func fetchLists() async throws
}

class ListsInterator {
    //MARK: - property
    weak var presenter: ListsPresenterProtocol?
    private var keychain = KeyChainManager.instance
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
    }
}
//MARK: - ListsIteratorProtocol
extension ListsInterator: ListsInteratorProtocol {
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
