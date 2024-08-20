//
//  AddListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 20.08.2024.
//

import UIKit


protocol AddListPresenterProtocol: AnyObject {
    
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
    
}
