//
//  ListsDetailPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import Foundation


protocol ListsDetailPresenterProtocol: AnyObject {
    
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
    
}
