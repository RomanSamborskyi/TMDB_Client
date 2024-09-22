//
//  ProfileModuleBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


class ProfileModuleBuilder {
    static func build(sessionId: String, networkManager: NetworkManager, imageDownloader: ImageDownloader, haptic: HapticFeedback) -> UIViewController {
        let view = ProfileViewController()
        let interactor = ProfileInteractor(sessionId: sessionId, networkManager: networkManager, imageDownloader: imageDownloader)
        let router = ProfileRouter()
        let presenter = ProfilePresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
