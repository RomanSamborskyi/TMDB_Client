//
//  RatedMoviePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit


protocol RatedMoviesPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didMoviesFetched(movies: [Movie], posters: [Int : UIImage])
}


class RatedMoviesPresenter {
    //MARK: - property
    weak var view: RatedMoviesViewProtocol?
    let interactor: RatedMoviesInteractorProtocol
    let router: RatedMoviesRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecycle
    init(interactor: RatedMoviesInteractorProtocol, router: RatedMoviesRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - RatedMoviePresenterProtocol
extension RatedMoviesPresenter: RatedMoviesPresenterProtocol {
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
