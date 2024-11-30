//
//  MovieRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit


protocol MovieRouterProtocol: AnyObject {
    func navigateTo(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, keychain: KeyChainManager)
}

class MovieRouter {
    //MARK: - property
    weak var view: MoviesViewController?
    
}
//MARK: - MovieRouterProtocol
extension MovieRouter: MovieRouterProtocol {
    func navigateTo(movie id: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, keychain: KeyChainManager) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: id, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId, keychain: keychain)
        view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
