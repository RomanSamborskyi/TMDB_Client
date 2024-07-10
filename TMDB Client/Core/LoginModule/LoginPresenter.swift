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
        if let _ = interactor.newSession?.success, let sessinId = interactor.newSession?.session_id {
            DispatchQueue.main.async {
                self.router.navigateToWellcomeViewController(with: sessinId)
            }
        }
    }
    func loginButtonDidTapped(login: String, password: String) {
        Task {
            do {
                try await interactor.sendLoginRequestwith(login: login, password: password)
            } catch let error as AppError {
                print(error)
            }
        }
    }
}
