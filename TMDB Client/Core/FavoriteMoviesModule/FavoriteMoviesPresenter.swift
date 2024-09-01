//
//  RatedMoviePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit


protocol FavoriteMoviesPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didMoviesFetched(movies: [Movie], posters: [Int : UIImage])
}


class FavoriteMoviesPresenter {
    //MARK: - property
    weak var view: FavoriteMoviesViewProtocol?
    let interactor: FavoriteMoviesInteractor
    let router: FavoriteMoviesRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecycle
    init(interactor: FavoriteMoviesInteractor, router: FavoriteMoviesRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - RatedMoviePresenterProtocol
extension FavoriteMoviesPresenter: FavoriteMoviesPresenterProtocol {
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchRatedList()
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
    func didMoviesFetched(movies: [Movie], posters: [Int : UIImage]) {
        view?.show(movies: movies, posters: posters)
    }
}
