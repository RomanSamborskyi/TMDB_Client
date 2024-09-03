//
//  AddListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 20.08.2024.
//

import UIKit
import NotificationCenter

protocol AddListPresenterProtocol: AnyObject {
    func createList(with title: String, _ description: String)
}


class AddListPresenter {
    //MARK: - property
    weak var view: AddListViewProtocol?
    let interactor: AddListInteractorProtocol
    let router: AddListRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecycle
    init(interactor: AddListInteractorProtocol, router: AddListRouterProtocol,haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - AddListPresenterProtocol
extension AddListPresenter: AddListPresenterProtocol {
    func createList(with title: String, _ description: String) {
        Task {
            do {
                try await interactor.addList(title: title, description: description)
                NotificationCenter.default.post(name: .listAdded, object: nil)
            
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
