//
//  LoginPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit


protocol LoginPresenterProtocol: AnyObject {
    @MainActor func loginButtonDidTapped(login: String, password: String)
    func didNewSessionStart(with session: Session)
}

class LoginPresenter {
    
    weak var view: LoginViewControllerProtocol?
    weak var viewRepresentable: AlertRepresentable?
    let interactor: LoginInteractorProtocol
    let router: LoginRouterProtocol
    let haptic: HapticFeedback
    
    init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
    
    
}
//MARK: - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {
    func didNewSessionStart(with session: Session) {
        if session.success {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                DispatchQueue.main.async {
                    self.router.navigateToWellcomeViewController(with: session.session_id, haptic: self.haptic, networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, keychain: self.interactor.keychain)
                }
            }
        }
    }
    @MainActor
    func loginButtonDidTapped(login: String, password: String) {
        Task {
            do {
                self.haptic.tacticFeddback(style: .soft)
                try await interactor.sendLoginRequestWith(login: login, password: password)
            } catch let error as AppError {
                self.haptic.tacticNotification(style: .error)
                switch error {
                case .badURL:
                    self.errorHandler(error: error)
                case .badResponse:
                    self.errorHandler(error: error)
                case .invalidData:
                    self.errorHandler(error: error)
                case .incorrectUserNameOrPass:
                    self.errorHandler(error: error)
                case .incorrectAccoutId:
                    self.errorHandler(error: error)
                case .invalidStatusCode:
                    self.errorHandler(error: error)
                }
            }
        }
    }
}
extension LoginPresenter: ErrorHandler {
    var viewPresentable: (any AlertRepresentable)? {
        view
    }
}
