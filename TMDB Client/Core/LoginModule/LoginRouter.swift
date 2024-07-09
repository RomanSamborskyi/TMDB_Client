//
//  LoginRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    func navigateToWellcomeViewController()
}

class LoginRouter {
    
    weak var view: LoginViewController?
    
}
//MARK: - LoginRouterProtocol
extension LoginRouter: LoginRouterProtocol {
    func navigateToWellcomeViewController() {
        let welcomeVC = WelcomeViewController()
        view?.navigationController?.pushViewController(welcomeVC, animated: true)
    }
}
