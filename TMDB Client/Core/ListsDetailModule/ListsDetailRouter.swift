//
//  ListsDetailRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.07.2024.
//

import UIKit


protocol ListsDetailRouterProtocol: AnyObject {
    func navigateTo(movie: Movie, poster: UIImage)
}

class ListsDetailRouter {
    //MARK: - prperty
    weak var view: ListsDetailViewController?
}
//MARK: - ListsDetailRouterProtocol
extension ListsDetailRouter: ListsDetailRouterProtocol {
    func navigateTo(movie: Movie, poster: UIImage) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: movie.id ?? 0, poster: poster)
        self.view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
