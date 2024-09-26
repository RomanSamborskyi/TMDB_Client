//
//  MoviesCastModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

class MoviesCastModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String, person: Int, poster: UIImage) -> UIViewController {
        let view = MoviesCastViewController()
        let interactor = MoviesCastInteractor(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, person: person, poster: poster)
        let router = MoviesCastRouter()
        let presenter = MoviesCastPresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.presenter = presenter
        presenter.view = view
        router.view = view
        interactor.presenter = presenter
        return view
    }
}
