//
//  MovieModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit


class MovieModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String) -> UIViewController {
        let view = MoviesViewController()
        let interactor = MovieInteractor(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId)
        let router = MovieRouter()
        let presenter = MoviePresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.view = view
        
        return view
    }
}
