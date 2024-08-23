//
//  AddListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 20.08.2024.
//

import UIKit


protocol AddListPresenterProtocol: AnyObject {
    func createList(with title: String, _ description: String)
}


class AddListPresenter {
    //MARK: - property
    weak var view: AddListViewProtocol?
    let interactor: AddListInteractorProtocol
    let router: AddListRouterProtocol
    //MARK: - lifecycle
    init(interactor: AddListInteractorProtocol, router: AddListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
//MARK: - AddListPresenterProtocol
extension AddListPresenter: AddListPresenterProtocol {
    func createList(with title: String, _ description: String) {
        Task {
            do {
                try await interactor.addList(title: title, description: description)
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
