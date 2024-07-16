//
//  MovieRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit


protocol MovieRouterProtocol: AnyObject {
    func navigateTo(movie id: Int, poster: UIImage)
}

class MovieRouter {
    //MARK: - property
    weak var view: MoviesViewController?
    
}
//MARK: - MovieRouterProtocol
extension MovieRouter: MovieRouterProtocol {
    func navigateTo(movie id: Int, poster: UIImage) {
        let detailVC = MovieDetailsModuleBuilder.build(movieId: id, poster: poster)
        view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
