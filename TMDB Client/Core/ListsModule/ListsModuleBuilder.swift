//
//  ListsModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


class ListsModuleBuilder {
    static func build() -> UIViewController {
        let view = ListsViewController()
        let interactor = ListsInterator()
        let router = ListsRouter()
        let presenter = ListsPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
