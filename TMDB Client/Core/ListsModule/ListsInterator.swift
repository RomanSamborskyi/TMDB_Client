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
    let networkManager = NetworkManager()
    let imageDownloader = ImageDownloader.instance
}
//MARK: - ListsIteratorProtocol
extension ListsInterator: ListsInteratorProtocol {
    func fetchLists() async throws {
        
        guard let userId = UserDefaults.standard.value(forKey: Constants.userIdKey) as? Int32 else {
            throw AppError.invalidData
        }
        
        guard let url = URL(string: AccountUrl.lists(key: Constants.apiKey, accountId: userId).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        guard let result = try await networkManager.fetchGET(type: ListsResponse.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        print(result.results)
    }
}
