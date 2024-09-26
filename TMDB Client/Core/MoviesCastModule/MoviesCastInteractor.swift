//
//  MoviesCastInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastInteractorProtocol: AnyObject {
    func showActorInfo()
}

class MoviesCastInteractor {
    //MARK: - property
    weak var presenter: MoviesCastPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let sessionId: String
    let person: Cast
    let poster: UIImage
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, person: Cast, poster: UIImage) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionId = sessionId
        self.person = person
        self.poster = poster
    }
}
//MARK: - MoviesCastInteractorProtocol
extension MoviesCastInteractor: MoviesCastInteractorProtocol {
    func showActorInfo() {
        presenter?.showInfo(actor: self.person, poster: self.poster)
    }
}
