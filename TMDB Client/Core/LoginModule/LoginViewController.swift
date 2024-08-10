//
//  LoginViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit
import NotificationCenter

protocol LoginViewControllerProtocol: AnyObject {
   //Empty protocol for communicating with another components in the module
}

class LoginViewController: UIViewController {
    //MARK: - property
    var presenter: LoginPresenterProtocol?
    private lazy var loginView = LoginView()
    private lazy var acticityView = ActivityView()
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
