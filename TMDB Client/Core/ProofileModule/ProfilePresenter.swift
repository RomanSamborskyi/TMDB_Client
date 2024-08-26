//
//  ProfilePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfilePresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didLogoutButtonTapped()
    func didUserFetched(user: UserProfile, with avatar: UIImage)
}

class ProfilePresenter {
    //MARK: - property
    weak var view: ProfileViewProtocol?
    let interactor: ProfileInteractorProtocol
    let router: ProfileRouterProtocol
    let haptic: HapticFeedback
    
    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
    
}
//MARK: - ProfilePresenterProtocol
extension ProfilePresenter: ProfilePresenterProtocol {
    func didLogoutButtonTapped() {
        Task {
            do {
                try await interactor.logout()
            } catch let error as AppError {
                print(error)
            }
        }
        DispatchQueue.main.async {
            self.router.navigateToLoginView(haptic: self.haptic)
        }
    }
    
    func didUserFetched(user: UserProfile, with avatar: UIImage) {
        view?.showUserData(user: user, with: avatar)
    }
    
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchUserData()
            } catch let error as AppError {
                print(error)
            }
        }
    }
}
