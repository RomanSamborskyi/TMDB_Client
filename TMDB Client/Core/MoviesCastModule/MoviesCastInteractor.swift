//
//  MoviesCastInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastInteractorProtocol: AnyObject {
    
}

class MoviesCastInteractor {
    //MARK: - property
    weak var presenter: MoviesCastPresenterProtocol?
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
//MARK: - MoviesCastInteractorProtocol
extension MoviesCastInteractor: MoviesCastInteractorProtocol {
    
}
