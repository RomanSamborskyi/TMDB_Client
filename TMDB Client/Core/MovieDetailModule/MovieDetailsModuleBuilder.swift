//
//  MovieDetailsModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


class MovieDetailsModuleBuilder {
    static func build(movieId: Int, poster: UIImage) -> UIViewController {
        
        let view = MovieDetailsViewController()
        let interactor = MovieDetailsInteractor(movieId: movieId, poster: poster)
        let router = MovieDetailsRouter() 
        let presenter = MovieDetailsPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.view = view
        
        return view
    }
}
