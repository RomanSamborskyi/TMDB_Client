//
//  SearcPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import UIKit


protocol SearchPresenterProtocol: AnyObject {
    func startSearch(text: String)
    func showResults(movies: [Movie], posters: [Int : UIImage])
}

class SearcPresenter {
    //MARK: - property
    weak var view: SearchViewControllerProtocol?
    let interactor: SearchInteractorProtocol
    let router: SearchRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecyccle
    init(interactor: SearchInteractorProtocol, router: SearchRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - SearchPresenterProtocol
extension SearcPresenter: SearchPresenterProtocol {
    func showResults(movies: [Movie], posters: [Int : UIImage]) {
        view?.showeResults(movies: movies, posters: posters)
    }
    func startSearch(text: String) {
        Task {
            do {
                try await interactor.fetchSearchResult(search: text)
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
