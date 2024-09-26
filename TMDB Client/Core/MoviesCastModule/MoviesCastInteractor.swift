//
//  MoviesCastInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastInteractorProtocol: AnyObject {
    func showActorInfo() async throws
}

class MoviesCastInteractor {
    //MARK: - property
    weak var presenter: MoviesCastPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let sessionId: String
    let person: Int
    let poster: UIImage
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, person: Int, poster: UIImage) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionId = sessionId
        self.person = person
        self.poster = poster
    }
}
//MARK: - MoviesCastInteractorProtocol
extension MoviesCastInteractor: MoviesCastInteractorProtocol {
    func showActorInfo() async throws {
        
        let session = URLSession.shared
        
        let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.actorDetails(apiKey: Constants.apiKey, actorId: person))
        
        guard let result = try await networkManager.fetchGET(type: Cast.self, session: session, request: request) else { return }
        
        presenter?.showInfo(actor: result, poster: self.poster)
    }
}
