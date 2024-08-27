//
//  AddToListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.08.2024.
//

import UIKit
import NotificationCenter

protocol AddToListPresenterProtocol: AnyObject {
    func didMovieAddedToList(with id: Int)
    func didSearchResultFetched(movies: [Movie], posters: [Int : UIImage])
    func didSearchStart(with text: String)
}


class AddToListPresenter {
    //MARK: - property
    weak var view: AddToListViewProtocol?
    let interactor: AddToListInteractorProtocol
    let router: AddToListRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecycle
    init(interactor: AddToListInteractorProtocol, router: AddToListRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - AddToListPresenterProtocol
extension AddToListPresenter: AddToListPresenterProtocol {
    func didSearchStart(with text: String) {
        Task {
            do {
                try await interactor.searchMovies(title: text)
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
    func didSearchResultFetched(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.view?.showResults(movies: movies, posters: posters)
        }
    }
    func didMovieAddedToList(with id: Int) {
        Task {
            do {
                try await interactor.addMovieToList(with: id)
                NotificationCenter.default.post(name: .movieAddedToList, object: nil)
                haptic.tacticNotification(style: .success)
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
