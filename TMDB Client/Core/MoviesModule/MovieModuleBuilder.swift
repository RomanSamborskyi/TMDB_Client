//
//  MovieModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit


class MovieModuleBuilder {
    static func build() -> UIViewController {
        let view = MoviesViewController()
        let interactor = MovieInteractor()
        let router = MovieRouter()
        let presenter = MoviePresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.view = view
        
        return view
    }
}
