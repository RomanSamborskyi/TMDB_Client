//
//  RatedMoviesRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit


protocol FavoriteMoviesRouterProtocol: AnyObject {
    func navigate(movieId: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String)
}



class FavoriteMoviesRouter {
    //MARK: - property
    weak var view: FavoriteMoviesViewController?
    //MARK: - lifecycle
}
//MARK: - RatedMoviesRouterProtocol
extension FavoriteMoviesRouter: FavoriteMoviesRouterProtocol {
    func navigate(movieId: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: movieId, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId)
        view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
