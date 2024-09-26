//
//  MoviesCastPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func showInfo(actor: Cast, poster: UIImage)
}

class MoviesCastPresenter {
    //MARK: - property
    weak var view: MoviesCastViewProtocol?
    let interactor: MoviesCastInteractorProtocol
    let router: MoviesCastRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecycle
    init(interactor: MoviesCastInteractorProtocol, router: MoviesCastRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - MoviesCastPresenterProtocol
extension MoviesCastPresenter: MoviesCastPresenterProtocol {
    func showInfo(actor: Cast, poster: UIImage) {
        view?.showActorInfo(actor: actor, poster: poster)
    }
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.showActorInfo()
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
