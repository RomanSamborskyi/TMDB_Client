//
//  AddToListModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.08.2024.
//

import UIKit


class AddToListModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int) -> UIViewController {
        let view = AddToListViewController()
        let interactor = AddToListInteractor(networkManager: networkManager, imageDownloader: imageDownloader, listId: listId)
        let router = AddToListRouter()
        let presenter = AddToListPresenter(interactor: interactor, router: router)
        
        view.persenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        return view
    }
}
