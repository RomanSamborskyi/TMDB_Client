//
//  AddToExistListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 04.09.2024.
//

import UIKit


protocol AddToExistListInteractorProtocol: AnyObject {
    func fetchLists() async throws
    func addMovieToList(listId: Int) async throws
    var keychain: KeyChainManager { get }
}


class AddToExistListInteractor {
    //MARK: - property
    weak var presenter: AddToExiistListPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let sessionId: String
    let movieId: Int
    let keychain: KeyChainManager
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager, sessionId: String, movieId: Int) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionId = sessionId
        self.movieId = movieId
        self.keychain = keychain
    }
}
//MARK: - AddToExistListInteractorProtocol
extension AddToExistListInteractor: AddToExistListInteractorProtocol {
    func fetchLists() async throws {
        
        guard let accountId = keychain.get(for: Constants.account_id) else {
            throw AppError.incorrectAccoutId
        }
        
        let session = URLSession.shared
        let request = try networkManager.requestFactory(type: NoBody(), urlData: AccountUrl.lists(key: Constants.apiKey, accountId: Int(accountId) ?? 0, sessionId: self.sessionId))
        guard let result = try await networkManager.fetchGET(type: ListsResponse.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        if let lists = result.results {
            presenter?.didListsFetched(lists: lists)
        }
    }
    func addMovieToList(listId: Int) async throws {
        
        let session = URLSession.shared

        let body = ["media_id" : self.movieId]
        
        let request = try networkManager.requestFactory(type: body, urlData: ListURL.addMovie(listId: listId, apiKey: Constants.apiKey, sessionId: sessionId))
        
        guard let _ = try await networkManager.fetchGET(type: ClearList.self, session: session, request: request) else {
            throw AppError.invalidData
        }
    }
}
