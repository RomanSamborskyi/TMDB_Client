//
//  LoginViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit
import NotificationCenter

protocol LoginViewControllerProtocol: AnyObject {
    func showAlert(title: String, messege: String)
}

class LoginViewController: UIViewController {
    //MARK: - property
    var presenter: LoginPresenterProtocol?
    private lazy var loginView = LoginView()
    private lazy var activityView = ActivityView()
    private lazy var isKeyboardShown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginView.delegate = self
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .customBackground
        setupLayout()
        addKeyboardObserver()
    }
    
    deinit {
        stopKeyboardObserve()
    }
}
//MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func didLoginButtonPressed(log: String, pass: String) {
        presenter?.loginButtonDidTapped(login: log, password: pass)
        if !log.isEmpty && !pass.isEmpty {
            activityView.isHidden = false
        }
    }
}
//MARK: - LoginViewControllerProtocol
extension LoginViewController: LoginViewControllerProtocol {
    func showAlert(title: String, messege: String) {
        let action = UIAlertAction(title: "Retry", style: .default) { _ in
            self.activityView.isHidden = true
        }
        self.showAlert(title: title, messege: messege, action: action)
    }
}
//MARK: - UI Layout
private extension LoginViewController {
    func setupLayout() {
        setupLoginView()
        setupActivityView()
        activityView.isHidden = true
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
        self.view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            activityView.widthAnchor.constraint(equalToConstant: 150),
            activityView.heightAnchor.constraint(equalToConstant: 150),
            activityView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}
//MARK: - keyboard observer
private extension LoginViewController {
    func addKeyboardObserver() {
       setupObserver()
    }
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown), name: UIResponder.keyboardWillShowNotification, object: nil)
         
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let gestrue = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        view.addGestureRecognizer(gestrue)
    }
    func stopKeyboardObserve() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func tapHandler(_ notification: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func keyboardWillShown(_ notification: Notification) {
        guard let keyboradFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboradFrame.cgRectValue.height
        
        if !isKeyboardShown {
            UIView.animate(withDuration: 0.3) {
                self.loginView.updateConstraint(with: keyboardHeight / 4)
                self.view.layoutIfNeeded()
                self.isKeyboardShown = true
                
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        if isKeyboardShown {
            UIView.animate(withDuration: 0.3) {
                self.loginView.resetConstraint()
                self.view.layoutIfNeeded()
                self.isKeyboardShown = false
                
            }
        }
    }
}
