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
}
//MARK: - WatchListPresenterProtocol
extension WatchlistPresenter: WatchlistPresenterProtocol {
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
