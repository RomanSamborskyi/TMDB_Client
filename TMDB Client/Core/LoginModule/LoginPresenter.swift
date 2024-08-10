//
//  LoginPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit


protocol LoginPresenterProtocol: AnyObject {
    func loginButtonDidTapped(login: String, password: String)
    func didNewSessionStart(with session: Session)
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
    func didNewSessionStart(with session: Session) {
        if session.success {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                DispatchQueue.main.async {
                    self.router.navigateToWellcomeViewController(with: session.session_id)
                }
            }
        }
    }
    func loginButtonDidTapped(login: String, password: String) {
        Task {
            do {
                try await interactor.sendLoginRequestwith(login: login, password: password)
            } catch let error as AppError {
                DispatchQueue.main.async { [weak self] in
                    switch error {
                    case .badURL:
                        self?.view?.showAlert(title: "Error", messege: error.localized)
                    case .badResponse:
                        self?.view?.showAlert(title: "Error", messege: error.localized)
                    case .invalidData:
                        self?.view?.showAlert(title: "Error", messege: error.localized)
                    case .incorrectUserNameOrPass:
                        self?.view?.showAlert(title: "Error", messege: error.localized)
                    case .incorrectAccoutId:
                        self?.view?.showAlert(title: "Error", messege: error.localized)
                    }
                }
            }
        }
    }
}
