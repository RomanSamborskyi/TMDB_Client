//
//  MoviePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit


protocol MoviePresenterProtocol: AnyObject {
        
}

class MoviePresenter {
    //MARK: - property
    weak var view: MovieViewProtocol?
    let interactor: MovieInteractorProtocol
    let router: MovieRouterProtocol
    
    //MARK: - lifecycle
    init(interactor: MovieInteractorProtocol, router: MovieRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}
//MARK: - MoviePresenterProtocol
extension MoviePresenter: MoviePresenterProtocol {
    
}
