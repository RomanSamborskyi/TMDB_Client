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
    private lazy var loginView: UIView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customBackground
        setupLayout()
    }
}
//MARK: - LoginViewControllerProtocol
extension LoginViewController: LoginViewControllerProtocol {
    
}
//MARK: - UI Layout
private extension LoginViewController {
    func setupLayout() {
        setupLoginView()
    }
    func setupLoginView() {
        self.view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
