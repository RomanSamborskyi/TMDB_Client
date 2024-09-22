//
//  AddToExiistListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 04.09.2024.
//

import UIKit


protocol AddToExiistListPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didListsFetched(lists: [List])
    func addMovieToExistingList(with id: Int)
    var haptic: HapticFeedback { get }
}


class AddToExiistListPresenter {
    //MARK: - property
    weak var view: AddToExistListViewProtocol?
    let haptic: HapticFeedback
    let interactor: AddToExistListInteractorProtocol
    let router: AddToExistListRouterProtocol
    //MARK: - lifecycle
    init(haptic: HapticFeedback, interactor: AddToExistListInteractorProtocol, router: AddToExistListRouterProtocol) {
        self.haptic = haptic
        self.interactor = interactor
        self.router = router
    }
}
//MARK: - AddToExiistListPresenterProtocol
extension AddToExiistListPresenter: AddToExiistListPresenterProtocol {
    func addMovieToExistingList(with id: Int) {
        Task {
            do {
                try await interactor.addMovieToList(listId: id)
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchLists()
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
    func didListsFetched(lists: [List]) {
        view?.showLists(lists: lists)
    }
}
