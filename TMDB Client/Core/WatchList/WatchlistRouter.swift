//
//  WatchListRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchlistRouterProtocol: AnyObject {
    func navigateToDetail(movie id: Int, poster: UIImage)
}

class WatchlistRouter {
    //MARK: - property
    weak var view: WatchlistViewController?
}
//MARK: - WatchListRouterProtocol
extension WatchlistRouter: WatchlistRouterProtocol {
    func navigateToDetail(movie id: Int, poster: UIImage) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: id, poster: poster)
        view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
