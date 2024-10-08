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
    var haptic: HapticFeedback { get }
    func addMovieTolist(with id: Int)
}

class WatchlistPresenter {
    //MARK: - property
    weak var view: WatchlistViewProtocol?
    let interactor: WatchlistInteractorProtocol
    let router: WatchlistRouterProtocol
    let haptic: HapticFeedback
    
    //MARK: - lifecycle
    init(interactor: WatchlistInteractorProtocol, router: WatchlistRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
//MARK: - WatchListPresenterProtocol
extension WatchlistPresenter: WatchlistPresenterProtocol {
    func addMovieTolist(with id: Int) {
        router.navigateToLists(networkManager: interactor.networkManager, imageDownloader: interactor.imageDownloader, sessionId: interactor.sessionId, haptic: self.haptic, movieId: id)
    }
    func didAddToFavoriteButtonPressed(for movie: Int) {
        Task {
            do {
                try await interactor.addToFavorite(movieId: movie)
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
            guard let self = self else { return }
            self.router.navigateToDetail(movie: id, poster: poster, networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, haptic: self.haptic, sessionId: self.interactor.sessionId)
        }
    }
    func didMoviesFetched(movies: [Movie], posters: [Int : UIImage]) {
        view?.show(movies: movies, posters: posters)
    }
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchWatchList()
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
                try await interactor.fetchWatchList()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
}
