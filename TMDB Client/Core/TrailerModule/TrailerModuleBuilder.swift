//
//  ThrillerModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit

class TrailerModuleBuilder {
    static func build(movieId: Int, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String) -> UIViewController {
        let view = TrailerViewController()
        let interactor = TrailerInteractor(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, movieId: movieId)
        let router = TrailerRouter()
        let presenter = TrailerPresenter(haptic: haptic, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.view = view
        
        return view
    }
}
