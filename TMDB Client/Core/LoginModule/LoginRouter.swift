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
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                window.rootViewController = welcomeVC
            }
        )
        window.makeKeyAndVisible()
    }
}
