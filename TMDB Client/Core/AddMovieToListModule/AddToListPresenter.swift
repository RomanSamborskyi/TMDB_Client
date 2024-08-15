//
//  AddToListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.08.2024.
//

import UIKit


protocol AddToListPresenterProtocol: AnyObject {
    
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
    
}
