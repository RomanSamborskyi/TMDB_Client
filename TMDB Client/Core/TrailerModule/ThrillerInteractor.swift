//
//  ThrillerInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit

protocol TrailerInteractorProtocol: AnyObject {
    func fetchTrailers() async throws
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
    var sessionId: String { get }
    var movieId: Int { get }
}

class TrailerInteractor {
    //MARK: - property
    weak var presenter: TrailerPresenterProtocol?
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
//MARK: - ThrillerInteractorProtocol
extension TrailerInteractor: TrailerInteractorProtocol {
    func fetchTrailers() async throws {
        
    }
}
