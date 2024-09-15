//
//  AddToExistListModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 04.09.2024.
//

import UIKit


class AddToExistListModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, movieId: Int) -> UIViewController {
        let view = AddToExistListViewController()
        let interactor = AddToExistListInteractor(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, movieId: movieId)
        let router = AddToExistListRouter()
        let presenter = AddToExiistListPresenter(haptic: haptic, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
