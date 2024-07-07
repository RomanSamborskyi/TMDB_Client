//
//  LoginViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit


protocol LoginViewControllerProtocol: AnyObject {
    
}

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
//MARK: - LoginViewControllerProtocol
extension LoginViewController: LoginViewControllerProtocol {
    
}
