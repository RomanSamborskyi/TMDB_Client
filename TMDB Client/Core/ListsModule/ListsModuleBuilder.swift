//
//  ListsModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


class ListsModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String) -> UIViewController {
        let view = ListsViewController()
        let interactor = ListsInterator(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId)
        let router = ListsRouter()
        let presenter = ListsPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
