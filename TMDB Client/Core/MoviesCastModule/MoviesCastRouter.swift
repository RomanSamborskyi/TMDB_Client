//
//  MoviesCastRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastRouterProtocol: AnyObject {
    func navigateTo(movie: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String)
}

class MoviesCastRouter {
    //MARK: - property
    weak var view: MoviesCastViewController?
    //MARK: - lifecycle
}
//MARK: - MoviesCastRouterProtocol
extension MoviesCastRouter: MoviesCastRouterProtocol {
    func navigateTo(movie: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: movie, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId)
        self.view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
