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
        let session = URLSession.shared
        
        let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.videos(apiKey: Constants.apiKey, movieId: self.movieId))
        
        guard let result = try await networkManager.fetch(type: TrailerResponse.self, session: session, request: request) else {
            throw AppError.invalidData
        }
       
        var urls: [Trailer?] = []
        
        urls.append(result.results.first(where: { $0.name == Constants.officialTrailer }) ?? nil)
        let mapped = urls.map { "https://www.youtube.com/watch?v=\($0?.key ?? "no key")"}
        presenter?.showTrailer(with: mapped)
    }
}
