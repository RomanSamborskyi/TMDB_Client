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
        router.navigateToFavoriteMoviesView(networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, sessionId: self.interactor.sessionId, haptic: self.haptic, accountId: self.interactor.accountId ?? 0, keychain: self.interactor.keychain)
    }
    
    func didRatedMoviesButtonTapped() {
        router.navigateToRatedMoviesView(networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, sessionId: self.interactor.sessionId, haptic: self.haptic, accountId: self.interactor.accountId ?? 0, keychain: self.interactor.keychain)
    }
    func didLogoutButtonTapped() {
        Task {
            do {
                try await interactor.logout()
                await MainActor.run {
                    self.router.navigateToLoginView(haptic: self.haptic, networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, keychain: self.interactor.keychain)
                }
            } catch let error as AppError {
                print(error)
            }
        }
    }
    
    func didUserFetched(user: UserProfile, with avatar: UIImage) {
        view?.showUserData(user: user, with: avatar)
    }
    
    func viewControllerDidLoad(viewController: UIViewController) {
        Task {
            try await fetchAllData(viewController: viewController)
        }
    }
}
//MARK: - extra functions
private extension ProfilePresenter {
    func fetchAllData(viewController: UIViewController) async throws {
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                do {
                    try await self.interactor.fetchUserData()
                } catch let error as AppError {
                    print(error)
                }
            }
            group.addTask(priority: .background) {
                do {
                    try await self.interactor.compareUserData()
                    await viewController.view.layoutIfNeeded()
                } catch let error as AppError {
                    print(error)
                }
            }
        }
    }
}
