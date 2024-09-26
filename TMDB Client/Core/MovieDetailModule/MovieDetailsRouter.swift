//
//  MovieDetailsRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


protocol MovieDetailsRouterProtocol: AnyObject {
    func navigateToLists(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int)
    func navigateToActorDetail(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, actor: Int, poster: UIImage)
}

class MovieDetailsRouter {
    //MARK: - property
    weak var view: MovieDetailsViewController?
}
//MARK: - MovieDetailsRouterProtocol
extension MovieDetailsRouter: MovieDetailsRouterProtocol {
    func navigateToActorDetail(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, actor: Int, poster: UIImage) {
        let listsVC = MoviesCastModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId, person: actor, poster: poster)
        view?.navigationController?.pushViewController(listsVC, animated: true)
    }
    func navigateToLists(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int) {
        let listsVC = AddToExistListModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic, movieId: movieId)
        view?.navigationController?.present(listsVC, animated: true)
    }
}
