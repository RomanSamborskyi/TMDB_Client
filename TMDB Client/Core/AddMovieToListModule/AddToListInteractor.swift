//
//  AddToListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.08.2024.
//

import UIKit


protocol AddToListInteractorProtocol: AnyObject {
    func addMovieToList(with id: Int) async throws
}


class AddToListInteractor {
    //MARK: property
    weak var presenter: AddToListPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let listId: Int
    let sessionId: String
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int, sessionId: String) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.listId = listId
        self.sessionId = sessionId
    }
}
//MARK: - AddToListInteractorProtocol
extension AddToListInteractor: AddToListInteractorProtocol {
    func addMovieToList(with id: Int) async throws {
        
        guard let url = URL(string: ListURL.addMovie(listId: listId, movieId: id, apiKey: Constants.apiKey, sessionId: sessionId).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = Constants.addMovieToListHeader
        
        let body: [String : Any] = ["media_id" : id]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        guard let result = try await networkManager.fetchGET(type: ClearList.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        print(result)
    }
}

