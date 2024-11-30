//
//  LoginModulBuilder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit


class LoginModulBuilder {
   static func build(haptic: HapticFeedback, networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager) -> UIViewController {
        let view = LoginViewController()
       let interactor = LoginInteractor(networkManager: networkManager, imageDownloader: imageDownloader, keychain: keychain)
        let router = LoginRouter()
        let presenter = LoginPresenter(interactor: interactor, router: router, haptic: haptic)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.view = view
        
        return view
    }
}
