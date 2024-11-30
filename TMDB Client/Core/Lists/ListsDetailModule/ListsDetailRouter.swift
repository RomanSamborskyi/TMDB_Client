//
//  ListsDetailRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.07.2024.
//

import UIKit


protocol ListsDetailRouterProtocol: AnyObject {
    func navigateTo(movie: Movie, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, keychain: KeyChainManager)
    func addMovieToList(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int, sessionId: String, haptic: HapticFeedback, movies: [Movie])
}

class ListsDetailRouter {
    //MARK: - prperty
    weak var view: ListsDetailViewController?
}
//MARK: - ListsDetailRouterProtocol
extension ListsDetailRouter: ListsDetailRouterProtocol {
    func addMovieToList(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int, sessionId: String, haptic: HapticFeedback, movies: [Movie]) {
        let vc = AddToListModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, listId: listId, sessionId: sessionId, haptic: haptic, movies: movies)
        self.view?.navigationController?.present(vc, animated: true)
    }
    func navigateTo(movie: Movie, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, keychain: KeyChainManager) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: movie.id ?? 0, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader, haptic: haptic, sessionId: sessionId, keychain: keychain)
        self.view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
