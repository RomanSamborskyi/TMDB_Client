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
}


class AddToListPresenter {
    //MARK: - property
    weak var view: AddToListViewProtocol?
    let interactor: AddToListInteractorProtocol
    let router: AddToListRouterProtocol
    //MARK: - lifecycle
    init(interactor: AddToListInteractorProtocol, router: AddToListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
//MARK: - AddToListPresenterProtocol
extension AddToListPresenter: AddToListPresenterProtocol {
    func didMovieAddedToList(with id: Int) {
        Task {
            do {
                try await interactor.addMovieToList(with: id)
                NotificationCenter.default.post(name: .movieAddedToList, object: nil)
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
