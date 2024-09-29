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
    func didMovieFetched(movie: MovieDetail, poster: UIImage, stat: MovieStat)
    func didCrewFetched(with cast: [Cast], photos: [Int : UIImage])
    func didMovieAddedToWatchlist()
    func didMovieAddedToFavorite()
    func didMovieAddedToList()
    func didPersonSelected(person: Int, poster: UIImage)
    func rateMovie(rate: Double)
    func showReviews(reviews: [Review], avatar: [String : UIImage])
    var haptic: HapticFeedback { get }
}

class MovieDetailsPresenter {
    //MARK: - property
    weak var view: MovieDetailsViewProtocol?
    let interactor: MovieDetailsInteractorProtocol
    let router: MovieDetailsRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecycle
    init(interactor: MovieDetailsInteractorProtocol, router: MovieDetailsRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
//MARK: - MovieDetailsInteractorProtocol
extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func showReviews(reviews: [Review], avatar: [String : UIImage]) {
        view?.showReviews(reviews: reviews, avatar: avatar)
    }
    func didPersonSelected(person: Int, poster: UIImage) {
        router.navigateToActorDetail(networkManager: interactor.networkManager, imageDownloader: interactor.imageDownloader, sessionId: interactor.sessionId, haptic: self.haptic, actor: person, poster: poster)
    }
    func didCrewFetched(with cast: [Cast], photos: [Int : UIImage]) {
        view?.showCrew(crew: cast, photo: photos)
    }
    func didMovieAddedToList() {
        router.navigateToLists(networkManager: interactor.networkManager, imageDownloader: interactor.imageDownloader, sessionId: interactor.sessionId, haptic: self.haptic, movieId: interactor.movieId)
    }
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
    func didMovieFetched(movie: MovieDetail, poster: UIImage, stat: MovieStat) {
        var fetchedMovie = movie
        
        fetchedMovie.watchList = stat.watchlist
        fetchedMovie.favorite = stat.favorite
        
        switch stat.rated {
        case .notRated:
            break
        case .rated(let ratedValue):
            fetchedMovie.myRate = ratedValue.value ?? 0
        case .none:
            break
        }
        view?.show(movie: fetchedMovie, poster: poster)
    }
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchMovieDetails()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
        Task(priority: .medium) {
            do {
                try await interactor.fetchCrew()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
        Task(priority: .medium) {
            do {
                try await interactor.fetchReviews()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
}
