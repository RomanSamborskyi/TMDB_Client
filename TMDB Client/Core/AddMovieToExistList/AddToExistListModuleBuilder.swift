//
//  AddToExistListModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 04.09.2024.
//

import UIKit


class AddToExistListModuleBuilder {
    func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int, sessionId: String, haptic: HapticFeedback) -> UIViewController {
        let view = AddToExistListViewController()
        let interactor = AddToExistListInteractor(networkManager: networkManager, imageDownloader: imageDownloader, listId: listId, sessionId: sessionId)
        let router = AddToExistListRouter()
        let presenter = AddToExiistListPresenter(haptic: haptic, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
