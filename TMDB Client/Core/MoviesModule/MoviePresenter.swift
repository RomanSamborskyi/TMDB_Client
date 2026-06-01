//
//  MoviePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit


protocol MoviePresenterProtocol: AnyObject {
    func viewControllerDidLoad(with tab: TopTabs)
    @MainActor func didMoviesFertched(movies: [Movie], with posters: [Int : UIImage])
    func didGenreFetched(genre: [Genre])
    func didMoviesByGenreFetched(movie: [Movie], with posters: [Int : UIImage])
    func viewControllerDidLoad(genre: Genre)
    @MainActor func didMovieSelected(with id: Int, poster: UIImage)
    var haptic: HapticFeedback { get }
}

class MoviePresenter {
    //MARK: - property
    weak var view: MovieViewProtocol?
    let interactor: MovieInteractorProtocol
    let router: MovieRouterProtocol
    let haptic: HapticFeedback
    
    //MARK: - lifecycle
    init(interactor: MovieInteractorProtocol, router: MovieRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - MoviePresenterProtocol
extension MoviePresenter: MoviePresenterProtocol {
    @MainActor
    func didMovieSelected(with id: Int, poster: UIImage) {
        self.router.navigateTo(movie: id, poster: poster, networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, haptic: self.haptic, sessionId: self.interactor.sessionId, keychain: self.interactor.keychain)
    }
    func viewControllerDidLoad(genre: Genre) {
        Task {
            do {
                try await interactor.fetchMovies(by: genre.id)
            } catch let error {
                self.handleErrors(error: error)
            }
        }
    }
    func didMoviesByGenreFetched(movie: [Movie], with posters: [Int : UIImage]) {
        view?.showMoviesByGenre(movies: movie, with: posters)
    }
    func didGenreFetched(genre: [Genre]) {
        view?.showGenre(genre: genre)
    }
    @MainActor
    func didMoviesFertched(movies: [Movie], with posters: [Int : UIImage]) {
        self.view?.show(movies: movies, with: posters)
    }
    func viewControllerDidLoad(with tab: TopTabs) {
        Task {
            await fetchAllData(with: tab)
        }
    }
}
//MARK: - extra functions
private extension MoviePresenter {
    func fetchAllData(with tab: TopTabs) async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                do {
                    switch tab {
                    case .trending:
                        try await self.interactor.fetchMovies(with: MoviesUrls.trending(key: Constants.apiKey))
                    case .topRated:
                        try await self.interactor.fetchMovies(with: MoviesUrls.topRated(key: Constants.apiKey))
                    case .upcoming:
                        try await self.interactor.fetchMovies(with: MoviesUrls.upcoming(key: Constants.apiKey))
                    }
                } catch let error {
                    self.handleErrors(error: error)
                }
            }
            group.addTask(priority: .userInitiated) {
                do {
                    try await self.interactor.fetchGenres()
                } catch let error {
                    self.handleErrors(error: error)
                }
            }
        }
    }
    func handleErrors(error: any Error) {
        if let error = error as? URLError {
            switch error.code {
            case .notConnectedToInternet:
                self.view?.showErrorAlert(message: error.localizedDescription, image: Constants.noWiFiIcon, title: Constants.noIternetError)
            default:
                self.view?.showErrorAlert(message: error.localizedDescription, image: Constants.unexpectedErrorIcon, title: Constants.unexpectedErrorTitle)
            }
        } else if let error = error as? AppError {
            self.view?.showErrorAlert(message: error.localizedDescription, image: Constants.unexpectedErrorIcon, title: Constants.unexpectedErrorTitle)
        }
    }
}
