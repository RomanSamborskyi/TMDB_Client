//
//  MovieDetailsPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


protocol MovieDetailsPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didMovieFetched(movie: Movie, poster: UIImage)
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
}
//MARK: - MovieDetailsInteractorProtocol
extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func didMovieFetched(movie: Movie, poster: UIImage) {
        view?.show(movie: movie, poster: poster)
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
