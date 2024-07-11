//
//  LoginRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    func navigateToWellcomeViewController(with sessionId: String)
}

class LoginRouter {
    
    weak var view: LoginViewController?
    
}
//MARK: - LoginRouterProtocol
extension LoginRouter: LoginRouterProtocol {
    func navigateToWellcomeViewController(with sessionId: String) {
        let welcomeVC = TabBarController(sessionId: sessionId)
        view?.navigationController?.pushViewController(welcomeVC, animated: true)
    }
}
