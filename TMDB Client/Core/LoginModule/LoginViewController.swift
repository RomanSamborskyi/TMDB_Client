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
    private lazy var loginView = LoginView()
    private lazy var acticityView = ActivityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginView.delegate = self
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .customBackground
        setupLayout()
    }
}
//MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func didLoginButtonPressed(log: String, pass: String) {
        presenter?.loginButtonDidTapped(login: log, password: pass)
        if !log.isEmpty && !pass.isEmpty {
            setupActivityView()
        }
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
    func setupActivityView() {
        self.view.addSubview(acticityView)
        acticityView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            acticityView.topAnchor.constraint(equalTo: view.topAnchor),
            acticityView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            acticityView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            acticityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
