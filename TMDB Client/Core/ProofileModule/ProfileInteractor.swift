//
//  WellcomeInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfileInteractorProtocol: AnyObject {
    
}

class ProfileInteractor {
    
    weak var presenter: ProfilePresenterProtocol?
    
}
//MARK: - WellcomeInteractorProtocol
extension ProfileInteractor: ProfileInteractorProtocol {
    
}
