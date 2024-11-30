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
    func didMovieSelected(with id: Int, poster: UIImage)
    func addMovieToExistList(with id: Int)
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
    func addMovieToExistList(with id: Int) {
        router.navigateToLists(networkManager: interactor.networkManager, imageDownloader: interactor.imageDownloader, sessionId: interactor.sessionId, haptic: self.haptic, movieId: id, keychain: self.interactor.keychain)
    }
    func didMovieSelected(with id: Int, poster: UIImage) {
        router.navigate(movieId: id, poster: poster, networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, haptic: self.haptic, sessionId: self.interactor.sessionId, keychain: self.interactor.keychain)
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
    func didMoviesFetched(movies: [Movie], posters: [Int : UIImage]) {
        view?.show(movies: movies, posters: posters)
    }
}
