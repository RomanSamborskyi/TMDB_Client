//
//  AddListModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 20.08.2024.
//

import UIKit


class AddListModuleBuilder {
    static func build() -> UIViewController {
        let view = AddListViewController()
        let interactor = AddListInteractor()
        let router = AddListRouter()
        let presenter = AddListPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
