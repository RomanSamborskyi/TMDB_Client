//
//  WatchListRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchlistRouterProtocol: AnyObject {
    func navigateToDetail(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback)
}

class WatchlistRouter {
    //MARK: - property
    weak var view: WatchlistViewController?
}
//MARK: - WatchListRouterProtocol
extension WatchlistRouter: WatchlistRouterProtocol {
    func navigateToDetail(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: id, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic)
        view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
