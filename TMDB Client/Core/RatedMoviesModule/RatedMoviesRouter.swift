//
//  RatedMoviesRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit


protocol RatedMoviesRouterProtocol: AnyObject {
    func navigate(movieId: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, keychain: KeyChainManager)
    func navigateToLists(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int, keychain: KeyChainManager)
}



class RatedMoviesRouter {
    //MARK: - property
    weak var view: RatedMoviesViewController?
    //MARK: - lifecycle
}
//MARK: - RatedMoviesRouterProtocol
extension RatedMoviesRouter: RatedMoviesRouterProtocol {
    func navigateToLists(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int, keychain: KeyChainManager) {
        let listsVC = AddToExistListModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic, movieId: movieId, keychain: keychain)
        view?.navigationController?.present(listsVC, animated: true)
    }
    func navigate(movieId: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, keychain: KeyChainManager) {
        let movieDetailVC = MovieDetailsModuleBuilder.build(movieId: movieId, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId, keychain: keychain)
        view?.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
