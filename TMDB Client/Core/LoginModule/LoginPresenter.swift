//
//  LoginPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit


protocol LoginPresenterProtocol: AnyObject {
    func loginButtonDidTapped(login: String, password: String)
    func didNewSessionStart()
}

class LoginPresenter {
    
    weak var view: LoginViewControllerProtocol?
    let interactor: LoginInteractorProtocol
    let router: LoginRouterProtocol
    
    init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    
}
//MARK: - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {
    func didNewSessionStart() {
        if let success = interactor.newSession?.success {
            DispatchQueue.main.async {
                self.router.navigateToWellcomeViewController()
            }
        }
    }
    func loginButtonDidTapped(login: String, password: String) {
        Task {
          try await interactor.sendLoginRequestwith(login: login, password: password)
        }
    }
}
