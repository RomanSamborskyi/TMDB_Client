//
//  RatedMoviesModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit


class FavoriteMoviesModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int) -> UIViewController {
        let view = FavoriteMoviesViewController()
        let interactor = FavoriteMoviesInteractor(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, accountId: accountId)
        let router = FavoriteMoviesRouter()
        let presenter = FavoriteMoviesPresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
