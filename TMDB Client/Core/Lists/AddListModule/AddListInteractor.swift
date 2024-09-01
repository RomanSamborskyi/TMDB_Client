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
        
        let session = URLSession.shared

        let body = CreateListRequest(name: title, description: description)
        
        let request = try networkManager.requestFactory(type: body, urlData: ListURL.create(apiKey: Constants.apiKey, sessionId: self.sessionId))
        
        guard let _ = try await networkManager.fetchGET(type: CreateListResponse.self, session: session, request: request) else {
            throw AppError.invalidData
        }
    }
}
