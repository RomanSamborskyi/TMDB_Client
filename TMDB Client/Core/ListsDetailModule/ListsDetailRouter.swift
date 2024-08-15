//
//  ListsDetailRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.07.2024.
//

import UIKit


protocol ListsDetailRouterProtocol: AnyObject {
    func navigateTo(movie: Movie, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader)
    func addMovieToList(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int)
}

class ListsDetailRouter {
    //MARK: - prperty
    weak var view: ListsDetailViewController?
}
//MARK: - ListsDetailRouterProtocol
extension ListsDetailRouter: ListsDetailRouterProtocol {
    func addMovieToList(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int) {
        let vc = AddToListModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, listId: listId)
        self.view?.navigationController?.present(vc, animated: true)
    }
    func navigateTo(movie: Movie, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: movie.id ?? 0, poster: poster, networkManager: networkManager, imageDownloader: imageDownloader)
        self.view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
