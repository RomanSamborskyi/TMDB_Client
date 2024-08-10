//
//  MovieDetailsPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit
import NotificationCenter

protocol MovieDetailsPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didMovieFetched(movie: MovieDetail, poster: UIImage, backdropPOster: UIImage, stat: MovieStat)
    func didMovieAddedToWatchlist()
    func didMovieAddedToFavorite()
    func rateMovie(rate: Double)
}

class MovieDetailsPresenter {
    //MARK: - property
    weak var view: MovieDetailsViewProtocol?
    let interactor: MovieDetailsInteractorProtocol
    let router: MovieDetailsRouterProtocol
    //MARK: - lifecycle
    init(interactor: MovieDetailsInteractorProtocol, router: MovieDetailsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
//MARK: - MovieDetailsInteractorProtocol
extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func rateMovie(rate: Double) {
        Task {
            do {
                try await interactor.addRate(rate: rate)
            } catch let error as AppError {
                print("Error of adding rate: \(error)")
            }
        }
    }
    func didMovieAddedToFavorite() {
        Task {
            do {
                try await interactor.addToFavorite()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
    func didMovieAddedToWatchlist() {
        Task(priority: .userInitiated) {
            do {
                try await interactor.addToWatchlist()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
        NotificationCenter.default.post(name: .movieAddedToWatchList, object: nil)
    }
    func didMovieFetched(movie: MovieDetail, poster: UIImage, backdropPOster: UIImage, stat: MovieStat) {
        var fetchedMovie = movie
        
        fetchedMovie.watchList = stat.watchlist
        fetchedMovie.favorite = stat.favorite
        
        switch stat.rated {
        case .notRated:
            print("not rated")
        case .rated(let ratedValue):
            fetchedMovie.myRate = ratedValue.value ?? 0
        case .none:
            break
        }
        view?.show(movie: fetchedMovie, poster: poster, backdropPoster: backdropPOster)
    }
    func viewControllerDidLoad() {
        let _ = Task {
            do {
                try await interactor.fetchMovieDetails()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
}
