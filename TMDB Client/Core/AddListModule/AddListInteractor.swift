//
//  AddListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 20.08.2024.
//

import UIKit


protocol AddListInteractorProtocol: AnyObject {
    func addList(title: String, description: String) async throws
}


class AddListInteractor {
    //MARK: - property
    weak var presenter: AddListPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let sessionId: String
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionId = sessionId
    }
}
//MARK: - AddListInteractorProtocol
extension AddListInteractor: AddListInteractorProtocol {
    func addList(title: String, description: String) async throws {
        
        guard let url = URL(string: ListURL.create(apiKey: Constants.apiKey, sessionId: self.sessionId).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = Constants.createListHeaders
        
        let body = CreateListRequest(name: title, description: description)
        
        request.httpBody = try JSONEncoder().encode(body)
        
        guard let result = try await networkManager.fetchGET(type: CreateListResponse.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        print(result)
    }
}
