//
//  ListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


protocol ListsPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
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
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchLists()
            } catch let error as AppError {
                print(error)
            }
        }
    }
}
