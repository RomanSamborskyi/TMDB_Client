//
//  MoviePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit


protocol MoviePresenterProtocol: AnyObject {
    func viewControllerDidLoad(with tab: TopTabs)
    func didMoviesFertched(movies: [Movie], with posters: [Int : UIImage])
    func didGenreFetched(genre: [Genre])
    func didMoviesByGenreFetched(movie: [Movie], with posters: [Int : UIImage])
    func viewControllerDidLoad(genre: Genre)
    func didMovieSelected(with id: Int, poster: UIImage)
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
    func didMovieSelected(with id: Int, poster: UIImage) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.router.navigateTo(movie: id, poster: poster, networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, haptic: self.haptic)
        }
    }
    func viewControllerDidLoad(genre: Genre) {
        _ = Task {
            do {
                try await interactor.fetchMovies(by: genre.id)
            } catch let error as AppError {
                print(error)
            }
        }
    }
    func didMoviesByGenreFetched(movie: [Movie], with posters: [Int : UIImage]) {
        view?.showMoviesByGenre(movies: movie, with: posters)
    }
    func didGenreFetched(genre: [Genre]) {
        view?.showGenre(genre: genre)
    }
    func didMoviesFertched(movies: [Movie], with posters: [Int : UIImage]) {
        DispatchQueue.main.async {
            self.view?.show(movies: movies, with: posters)
        }
    }
    func viewControllerDidLoad(with tab: TopTabs) {
        Task {
            do {
                switch tab {
                case .trending:
                    try await interactor.fetchMovies(with: MoviesUrls.trending(key: Constants.apiKey).url)
                case .topRated:
                    try await interactor.fetchMovies(with: MoviesUrls.topRated(key: Constants.apiKey).url)
                case .upcoming:
                    try await interactor.fetchMovies(with: MoviesUrls.upcoming(key: Constants.apiKey).url)
                }
            } catch let error as AppError {
                print(error)
            }
        }
        Task(priority: .userInitiated) {
            do {
                try await interactor.fetchGenres()
            } catch let error as AppError {
                print("Error of fetching genre: \(error)")
            }
        }
    }
}
