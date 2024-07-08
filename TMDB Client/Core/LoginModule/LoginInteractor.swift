//
//  LoginInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit

protocol LoginInteractorProtocol: AnyObject {
    func sendLoginRequestwith(login: String, password: String)
}

class LoginInteractor {
    
    let apiKey: String = "14512c9189d3ba6fe3a1de6324ad576a"
    weak var presenter: LoginPresenterProtocol?
    
}
//MARK: - LoginInteractorProtocol
extension LoginInteractor: LoginInteractorProtocol {
    func sendLoginRequestwith(login: String, password: String) {
        
    }
}
