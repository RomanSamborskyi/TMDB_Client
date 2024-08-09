//
//  WatchListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchlistPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didMoviesFetched(movies: [Movie], posters: [Int : UIImage])
    func didMovieSelected(movie id: Int, poster: UIImage)
    func viewControllerWillAppear()
    func didAddToFavoriteButtonPressed(for movie: Int)
}

class WatchlistPresenter {
    //MARK: - property
    weak var view: WatchlistViewProtocol?
    let interactor: WatchlistInteractorProtocol?
    let router: WatchlistRouterProtocol?
    
    //MARK: - lifecycle
    init(interactor: WatchlistInteractorProtocol, router: WatchlistRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
//MARK: - WatchListPresenterProtocol
extension WatchlistPresenter: WatchlistPresenterProtocol {
    func didAddToFavoriteButtonPressed(for movie: Int) {
        Task {
            do {
                try await interactor?.addToFavorite(movieId: movie)
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
    func viewControllerWillAppear() {
        addObserver()
    }
    func didMovieSelected(movie id: Int, poster: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.router?.navigateToDetail(movie: id, poster: poster)
        }
    }
    func didMoviesFetched(movies: [Movie], posters: [Int : UIImage]) {
        view?.show(movies: movies, posters: posters)
    }
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor?.fetchWatchList()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: - watchlist observer
extension WatchlistPresenter {
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didMovieAddedToWatchList), name: .movieAddedToWatchList, object: nil)
    }
    @objc func didMovieAddedToWatchList(selector: Notification ) {
        Task {
            do {
                try await interactor?.fetchWatchList()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
}
