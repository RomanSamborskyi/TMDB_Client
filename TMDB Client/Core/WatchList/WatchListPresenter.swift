//
//  WatchListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchListPresenterProtocol: AnyObject {
    
}

class WatchListPresenter {
    //MARK: - property
    weak var view: WatchListViewProtocol?
    let interactor: WatchListInteractorProtocol?
    let router: WatchListRouterProtocol?
    
    //MARK: - lifecycle
    init(interactor: WatchListInteractorProtocol, router: WatchListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
//MARK: - WatchListPresenterProtocol
extension WatchListPresenter: WatchListPresenterProtocol {
    
}
