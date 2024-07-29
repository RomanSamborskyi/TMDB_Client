//
//  ListsDetailModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.07.2024.
//

import UIKit


class ListsDetailModuleBuilder {
    static func build() -> UIViewController {
        let view = ListsDetailViewController()
        let interactor = ListsDetailInteractor()
        let router = ListsDetailRouter()
        let presenter = ListsDetailPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
