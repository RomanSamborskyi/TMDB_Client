//
//  AddListModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 20.08.2024.
//

import UIKit


class AddListModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String) -> UIViewController {
        let view = AddListViewController()
        let interactor = AddListInteractor(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId)
        let router = AddListRouter()
        let presenter = AddListPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
