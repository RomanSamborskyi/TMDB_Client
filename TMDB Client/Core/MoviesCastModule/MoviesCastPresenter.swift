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
    func showActorfilmography(movies: [Movie], posters: [Int: UIImage])
    func didMovieSelected(movieId: Int, poster: UIImage)
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
    func didMovieSelected(movieId: Int, poster: UIImage) {
        router.navigateTo(movie: movieId, poster: poster, networkManager: interactor.networkManager, imageDownloader: interactor.imageDownloader, haptic: self.haptic, sessionId: interactor.sessionId, keychain: self.interactor.keychain)
    }
    func showActorfilmography(movies: [Movie], posters: [Int : UIImage]) {
        view?.showActorsFilmography(movies: movies, posters: posters)
    }
    func showInfo(actor: Cast, poster: UIImage) {
        view?.showActorInfo(actor: actor, poster: poster)
    }
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchActorInfo()
            } catch let error as AppError {
                print(error.localized)
            }
        }
        Task(priority: .medium) {
            do {
                try await interactor.fetchActorsFilmography()
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
