//
//  WatchListModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


class WatchlistModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader) -> UIViewController {
        let view = WatchlistViewController()
        let interactor = WatchlistInteractor(networkManager: networkManager, imageDownloader: imageDownloader)
        let router = WatchlistRouter()
        let presenter = WatchlistPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
