//
//  SearchInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import Foundation


protocol SearchInteractorProtocol: AnyObject {
    func fetchSearchResult() async throws
}

class SearchInteractor {
    //MARK: - property
    weak var presenter: SearchPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let sessionID: String
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionID: String) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionID = sessionID
    }
}
//MARK: - SearchInteractorProtocol
extension SearchInteractor: SearchInteractorProtocol {
    func fetchSearchResult() async throws {
        
    }
}
