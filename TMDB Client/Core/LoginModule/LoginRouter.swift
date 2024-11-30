//
//  LoginRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    func navigateToWellcomeViewController(with sessionId: String, haptic: HapticFeedback, networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager)
}

class LoginRouter {
    
    weak var view: LoginViewController?
    
}
//MARK: - LoginRouterProtocol
extension LoginRouter: LoginRouterProtocol {
    func navigateToWellcomeViewController(with sessionId: String, haptic: HapticFeedback, networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager) {
        let welcomeVC = TabBarController(sessionId: sessionId, haptic: haptic, networkManager: networkManager, imageDownloader: imageDownloader, keychain: keychain)
        view?.navigationController?.pushViewController(welcomeVC, animated: true)
    }
}
