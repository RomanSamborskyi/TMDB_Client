//
//  SearchModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import UIKit


class SearchModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback, sessionId: String) -> UIViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor(networkManager: networkManager, imageDownloader: imageDownloader, sessionID: sessionId)
        let router = SearchRouter()
        let presenter = SearcPresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.preseter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        return view
    }
}
