//
//  ProfilePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfilePresenterProtocol: AnyObject {
    func viewControllerDidLoad(viewController: UIViewController)
    func didLogoutButtonTapped()
    func didRatedMoviesButtonTapped()
    func didFavoriteMoviesButtonTapped()
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
    func didFavoriteMoviesButtonTapped() {
        router.navigateToFavoriteMoviesView(networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, sessionId: self.interactor.sessionId, haptic: self.haptic, accountId: self.interactor.accountId ?? 0)
    }
    
    func didRatedMoviesButtonTapped() {
        router.navigateToRatedMoviesView(networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, sessionId: self.interactor.sessionId, haptic: self.haptic, accountId: self.interactor.accountId ?? 0)
    }
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
    
    func viewControllerDidLoad(viewController: UIViewController) {
        Task {
            do {
                try await interactor.fetchUserData()
            } catch let error as AppError {
                print(error)
            }
        }
        Task(priority: .background) {
            do {
                try await interactor.compareUserData()
                await viewController.view.layoutIfNeeded()
            } catch let error as AppError {
                print(error)
            }
        }
    }
}
