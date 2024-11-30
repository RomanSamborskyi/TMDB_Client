//
//  RatedMoviesModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit


class RatedMoviesModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int, keychain: KeyChainManager) -> UIViewController {
        let view = RatedMoviesViewController()
        let interactor = RatedMoviesInteractor(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, accountId: accountId, keychain: keychain)
        let router = RatedMoviesRouter()
        let presenter = RatedMoviesPresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
