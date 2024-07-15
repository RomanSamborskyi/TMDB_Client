//
//  WatchListModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


class WatchListModuleBuilder {
    static func build() -> UIViewController {
        let view = WatchListViewController()
        let interactor = WatchListInteractor()
        let router = WatchListRouter()
        let presenter = WatchListPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
