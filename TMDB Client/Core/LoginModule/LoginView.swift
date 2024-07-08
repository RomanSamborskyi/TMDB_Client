//
//  LoginView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 08.07.2024.
//

import UIKit

class LoginView: UIView {

    //MARK: - property
    lazy var login: String = ""
    lazy var password: String = ""
    private lazy var isSecuretextField: Bool = true
    private lazy var wellcomeLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var loginLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var loginTextField: UITextField = {
        let txtFld = UITextField()
        return txtFld
    }()
    private lazy var passwordLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var passwordTextField: UITextField = {
        let txtFld = UITextField()
        return txtFld
    }()
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal errror from LoginView")
    }
}
//MARK: - UI Layout
private extension LoginView {
    func setupLayout() {
        setupWellcomeLabel()
        setupLoginLabel()
        setupLoginTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupLoginButton()
    }
    func setupWellcomeLabel() {
        self.addSubview(wellcomeLabel)
        wellcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        wellcomeLabel.text = "TMDB Client"
        wellcomeLabel.font = .systemFont(ofSize: 35, weight: .bold)
        wellcomeLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            wellcomeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: UIScreen.main.bounds.height / 6),
            wellcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    func setupLoginLabel() {
        self.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Login"
        loginLabel.font = .systemFont(ofSize: 15)
        loginLabel.textColor = .lightGray
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: wellcomeLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05),
            loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.height * 0.04),
            loginLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6),
            loginLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func setupLoginTextField() {
        self.addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.textAlignment = .left
        loginTextField.borderStyle = .roundedRect
        loginTextField.layer.cornerRadius = 15
        loginTextField.clipsToBounds = true
        loginTextField.placeholder = "Enter user name or email..."
      
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 5),
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.height * 0.03),
            loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIScreen.main.bounds.height * 0.03),
            loginTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06),
        ])
    }
    func setupPasswordLabel() {
        self.addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Password"
        passwordLabel.font = .systemFont(ofSize: 15)
        passwordLabel.textColor = .lightGray
        
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.height * 0.04),
            passwordLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6),
            passwordLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func setupPasswordTextField() {
        self.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.textAlignment = .left
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.clipsToBounds = true
        passwordTextField.placeholder = "Enter password..."
        passwordTextField.isSecureTextEntry = isSecuretextField
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.height * 0.03),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIScreen.main.bounds.height * 0.03),
            passwordTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06),
        ])
    }
    func setupLoginButton() {
        self.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 15
        loginButton.clipsToBounds = true
        loginButton.titleLabel?.textColor = .white
        loginButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.09),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.height * 0.03),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIScreen.main.bounds.height * 0.03),
            loginButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06),
        ])
    }
    @objc func buttonAction(selectro: Selector) {
        login = loginTextField.text ?? "no text"
        password = passwordTextField.text ?? "no password"
        print(login)
        print(password)
    }
}
