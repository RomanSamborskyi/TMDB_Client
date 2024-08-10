//
//  LoginView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 08.07.2024.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
   func didLoginButtonPressed(log: String, pass: String)
}

class LoginView: UIView {

    //MARK: - constraints
    var loginViewTopConstraint: NSLayoutConstraint!
    var logibViewTopConstraintValue: CGFloat = UIScreen.main.bounds.height / 6
    //MARK: - property
    weak var delegate: LoginViewDelegate?
    var login: String? = nil
    var password: String? = nil
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
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
    private lazy var isSecureButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //MARK: - methods
    func updateConstraint(with value: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            let newValue = self.logibViewTopConstraintValue - value
            self.loginViewTopConstraint.constant = newValue
            self.layoutIfNeeded()
        }
    }
    func resetConstraint() {
        self.loginViewTopConstraint.constant = UIScreen.main.bounds.height / 6
    }
}
//MARK: - UI Layout
private extension LoginView {
    func setupLayout() {
        setupLogoImageView()
        setupLoginLabel()
        setupLoginTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupLoginButton()
        setupISSecureButton()
        setupWellcomeLabel()
    }
    func setupLogoImageView() {
        self.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "logo")
        logoImage.contentMode = .scaleAspectFill
        
        loginViewTopConstraint = logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: logibViewTopConstraintValue)
        NSLayoutConstraint.activate([
            loginViewTopConstraint,
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5),
            logoImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1)
        ])
        
    }
    func setupWellcomeLabel() {
        self.addSubview(wellcomeLabel)
        wellcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        wellcomeLabel.text = "This application uses TMDB and the TMDB APIs but is not endorsed, certified, or otherwise approved by TMDB"
        wellcomeLabel.font = .systemFont(ofSize: 12, weight: .regular)
        wellcomeLabel.textAlignment = .center
        wellcomeLabel.numberOfLines = 0
        wellcomeLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            wellcomeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            wellcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wellcomeLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5),
        ])
    }
    func setupLoginLabel() {
        self.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Login"
        loginLabel.font = .systemFont(ofSize: 15)
        loginLabel.textColor = .lightGray
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05),
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
        loginTextField.layer.cornerRadius = 20
        loginTextField.clipsToBounds = true
        loginTextField.backgroundColor = .white
        loginTextField.textColor = .black
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.height))
        loginTextField.leftView = padding
        loginTextField.leftViewMode = .always
        loginTextField.rightView = padding
        loginTextField.rightViewMode = .always
        
        let attributes: [NSAttributedString.Key: Any] = [
                  .foregroundColor: UIColor.lightGray,
                  .font: UIFont.systemFont(ofSize: 16)
              ]
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Enter username", attributes: attributes)
      
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
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.clipsToBounds = true
        passwordTextField.backgroundColor = .white
        passwordTextField.textColor = .black
        passwordTextField.isSecureTextEntry = true
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.height))
        passwordTextField.leftView = padding
        passwordTextField.rightView = padding
        passwordTextField.leftViewMode = .always
        passwordTextField.rightViewMode = .always
        
        let attributes: [NSAttributedString.Key: Any] = [
                  .foregroundColor: UIColor.lightGray,
                  .font: UIFont.systemFont(ofSize: 16)
              ]
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter your password", attributes: attributes)
        
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
        loginButton.setTitleColor(UIColor.customBackground, for: .normal)
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        loginButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.09),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.height * 0.03),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIScreen.main.bounds.height * 0.03),
            loginButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06),
        ])
    }
    func setupISSecureButton() {
        self.addSubview(isSecureButton)
        isSecureButton.translatesAutoresizingMaskIntoConstraints = false
        isSecureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        isSecureButton.imageView?.tintColor = .black
        isSecureButton.addTarget(self, action: #selector(isSecureAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            isSecureButton.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            isSecureButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIScreen.main.bounds.height * 0.05),
            isSecureButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06),
            isSecureButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.06),
        ])
    }
}
//MARK: - button action
extension LoginView {
    @objc func buttonAction(selectro: Selector) {
        self.login = loginTextField.text ?? "no text"
        self.password = passwordTextField.text ?? "no password"
        guard let log = login,
              let pass = password else { return }
        self.delegate?.didLoginButtonPressed(log: log, pass: pass)
    }
    @objc func isSecureAction(selecter: Selector) {
        self.passwordTextField.isSecureTextEntry.toggle()
        
        switch passwordTextField.isSecureTextEntry {
        case true:
            self.isSecureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        case false:
            self.isSecureButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
}
