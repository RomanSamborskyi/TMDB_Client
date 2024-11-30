//
//  MovieDetailsRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


protocol MovieDetailsRouterProtocol: AnyObject {
    func navigateToLists(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int, keychain: KeyChainManager)
    func navigateToThriller(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int)
    func navigateToActorDetail(networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager, sessionId: String, haptic: HapticFeedback, actor: Int, poster: UIImage)
    func navigateTo(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, keychain: KeyChainManager)
}

class MovieDetailsRouter {
    //MARK: - property
    weak var view: MovieDetailsViewController?
}
//MARK: - MovieDetailsRouterProtocol
extension MovieDetailsRouter: MovieDetailsRouterProtocol {
    func navigateToThriller(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int) {
        let thrillerVC = TrailerModuleBuilder.build(movieId: movieId, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId)
        view?.navigationController?.present(thrillerVC, animated: true)
    }
    func navigateTo(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, keychain: KeyChainManager) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: id, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId, keychain: keychain)
        view?.navigationController?.pushViewController(detailVC, animated: true)
    }
    func navigateToActorDetail(networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager, sessionId: String, haptic: HapticFeedback, actor: Int, poster: UIImage) {
        let listsVC = MoviesCastModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, keychain: keychain, haptic: haptic, sessionId: sessionId, person: actor, poster: poster)
        view?.navigationController?.pushViewController(listsVC, animated: true)
    }
    func navigateToLists(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int, keychain: KeyChainManager) {
        let listsVC = AddToExistListModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic, movieId: movieId, keychain: keychain)
        view?.navigationController?.present(listsVC, animated: true)
    }
}
