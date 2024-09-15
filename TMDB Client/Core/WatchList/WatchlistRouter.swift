//
//  WatchListRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchlistRouterProtocol: AnyObject {
    func navigateToDetail(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String)
    func navigateToLists(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int)
}

class WatchlistRouter {
    //MARK: - property
    weak var view: WatchlistViewController?
}
//MARK: - WatchListRouterProtocol
extension WatchlistRouter: WatchlistRouterProtocol {
    func navigateToLists(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int) {
        let listsVC = AddToExistListModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic, movieId: movieId)
        view?.navigationController?.present(listsVC, animated: true)
    }
    func navigateToDetail(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: id, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId)
        view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
