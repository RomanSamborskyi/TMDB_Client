//
//  AddToExistListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 04.09.2024.
//

import UIKit


protocol AddToExistListInteractorProtocol: AnyObject {
    
}


class AddToExistListInteractor {
    //MARK: - property
    weak var presenter: AddToExiistListPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let sessionId: String
    let movieId: Int
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, movieId: Int) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionId = sessionId
        self.movieId = movieId
    }
}
//MARK: - AddToExistListInteractorProtocol
extension AddToExistListInteractor: AddToExistListInteractorProtocol {
    
}
