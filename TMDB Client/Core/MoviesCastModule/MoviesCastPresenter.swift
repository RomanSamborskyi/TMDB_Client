//
//  MoviesCastPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastPresenterProtocol: AnyObject {
    
}

class MoviesCastPresenter {
    //MARK: - property
    weak var view: MoviesCastViewProtocol?
    let interactor: MoviesCastInteractorProtocol
    let router: MoviesCastRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecycle
    init(interactor: MoviesCastInteractorProtocol, router: MoviesCastRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - MoviesCastPresenterProtocol
extension MoviesCastPresenter: MoviesCastPresenterProtocol {
    
}