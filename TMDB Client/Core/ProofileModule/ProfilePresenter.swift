//
//  ProfilePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfilePresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didUserFetched(user: UserProfile, with avatar: UIImage)
}

class ProfilePresenter {
    
    weak var view: ProfileViewProtocol?
    let interactor: ProfileInteractorProtocol
    let router: ProfileRouterProtocol
    
    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}
//MARK: - ProfilePresenterProtocol
extension ProfilePresenter: ProfilePresenterProtocol {
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
