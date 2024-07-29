//
//  ListsDetailPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import Foundation


protocol ListsDetailPresenterProtocol: AnyObject {
    func didViewControllerLoad()
}

class ListsDetailPresenter {
    //MARK: - property
    weak var view: ListsDetailViewProtocol?
    let interactor: ListsDetailInteractorProtocol?
    let router: ListsDetailRouterProtocol?
    //MARK: - lifecycle
    init(interactor: ListsDetailInteractorProtocol?, router: ListsDetailRouterProtocol?) {
        self.interactor = interactor
        self.router = router
    }
}
//MARK: - ListsDetailPresenterProtocol
extension ListsDetailPresenter: ListsDetailPresenterProtocol {
    func didViewControllerLoad() {
        Task {
            do {
                try await interactor?.fetchDetails()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
}
