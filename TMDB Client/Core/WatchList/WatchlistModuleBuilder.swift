//
//  WatchListModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


class WatchlistModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, keychain: KeyChainManager) -> UIViewController {
        let view = WatchlistViewController()
        let interactor = WatchlistInteractor(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, keychain: keychain)
        let router = WatchlistRouter()
        let presenter = WatchlistPresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
