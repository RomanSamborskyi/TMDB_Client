//
//  RatedMoviePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit


protocol RatedMoviesPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didMoviesFetched(movies: [Movie], posters: [Int : UIImage], isFetched: Bool)
    func didMovieSelected(id: Int, poster: UIImage)
    func didMovieAddedToFavorite(with id: Int)
    func addMovieToExistList(with id: Int)
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
    func addMovieToExistList(with id: Int) {
        router.navigateToLists(networkManager: interactor.networkManager, imageDownloader: interactor.imageDownloader, sessionId: interactor.sessionId, haptic: self.haptic, movieId: id)
    }
    func didMovieAddedToFavorite(with id: Int) {
        Task {
            do {
                try await interactor.addToFavorite(movieId: id)
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
    func didMovieSelected(id: Int, poster: UIImage) {
        router.navigate(movieId: id, poster: poster, networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, haptic: self.haptic, sessionId: self.interactor.sessionId)
    }
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchRatedList()
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
    func didMoviesFetched(movies: [Movie], posters: [Int : UIImage], isFetched: Bool) {
        view?.show(movies: movies, posters: posters, isFetched: isFetched)
    }
}
