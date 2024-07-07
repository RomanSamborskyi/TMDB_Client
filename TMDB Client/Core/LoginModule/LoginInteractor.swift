//
//  LoginInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit

protocol LoginInteractorProtocol: AnyObject {
    
}

class LoginInteractor {
    
    weak var presenter: LoginPresenterProtocol?
    
}
//MARK: - LoginInteractorProtocol
extension LoginInteractor: LoginInteractorProtocol {
    
}
