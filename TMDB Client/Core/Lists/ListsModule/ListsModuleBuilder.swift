//
//  ListsModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


class ListsModuleBuilder {
    static func build(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, keychain: KeyChainManager) -> UIViewController {
        let view = ListsViewController()
        let interactor = ListsInterator(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, keychain: keychain)
        let router = ListsRouter()
        let presenter = ListsPresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
