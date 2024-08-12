//
//  ListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


protocol ListsPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didListsFetched(lists: [List])
    func didListsSelected(list: Int)
    func clearList(with id: Int)
}


class ListsPresenter {
    //MARK: - property
    weak var view: ListsViewControllerProtocol?
    let interactor: ListsInteratorProtocol
    let router: ListsRouterProtocol
    
    //MARK: - lifecycle
    init(interactor: ListsInteratorProtocol, router: ListsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
//MARK: - ListsPresenterProtocol
extension ListsPresenter: ListsPresenterProtocol {
    func clearList(with id: Int) {
        Task {
            do {
                try await interactor.clearList(with: id)
            } catch let error as AppError {
                print(error)
            }
        }
    }
    func didListsSelected(list: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.router.navigateToList(with: list)
        }
    }
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchLists()
            } catch let error as AppError {
                print(error)
            }
        }
    }
    func didListsFetched(lists: [List]) {
        view?.show(lists: lists)
    }
}
