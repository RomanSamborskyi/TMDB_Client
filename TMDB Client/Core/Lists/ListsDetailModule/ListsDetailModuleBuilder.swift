//
//  ListsDetailModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.07.2024.
//

import UIKit


class ListsDetailModuleBuilder {
    static func build(list id: Int, networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, keychain: KeyChainManager) -> UIViewController {
        let view = ListsDetailViewController()
        let interactor = ListsDetailInteractor(listId: id, networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, keychain: keychain)
        let router = ListsDetailRouter()
        let presenter = ListsDetailPresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
