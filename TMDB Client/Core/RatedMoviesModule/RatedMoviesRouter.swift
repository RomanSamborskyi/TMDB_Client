//
//  RatedMoviesRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit


protocol RatedMoviesRouterProtocol: AnyObject {
    func navigate(movieId: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String)
}



class RatedMoviesRouter {
    //MARK: - property
    weak var view: RatedMoviesViewController?
    //MARK: - lifecycle
}
//MARK: - RatedMoviesRouterProtocol
extension RatedMoviesRouter: RatedMoviesRouterProtocol {
    func navigate(movieId: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String) {
        let movieDetailVC = MovieDetailsModuleBuilder.build(movieId: movieId, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId)
        view?.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
