//
//  ProfilePresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfilePresenterProtocol: AnyObject {
    
}

class ProfilePresenter {
    
    weak var view: ProfileViewProtocol?
    let interactor: ProfileInteractorProtocol
    let router: ProfileRouterProtocol
    
    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}
//MARK: - ProfilePresenterProtocol
extension ProfilePresenter: ProfilePresenterProtocol {
    
}
