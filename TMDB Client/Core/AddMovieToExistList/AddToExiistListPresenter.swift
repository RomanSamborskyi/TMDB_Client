//
//  AddToExiistListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 04.09.2024.
//

import UIKit


protocol AddToExiistListPresenterProtocol: AnyObject {
    
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
    
}
