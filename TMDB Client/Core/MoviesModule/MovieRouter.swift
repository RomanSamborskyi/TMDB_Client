//
//  MovieRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit


protocol MovieRouterProtocol: AnyObject {
    func navigateTo(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback)
}

class MovieRouter {
    //MARK: - property
    weak var view: MoviesViewController?
    
}
//MARK: - MovieRouterProtocol
extension MovieRouter: MovieRouterProtocol {
    func navigateTo(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: id, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic)
        view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
