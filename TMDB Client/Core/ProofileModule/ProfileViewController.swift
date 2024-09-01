//
//  WelcomeViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func showUserData(user: UserProfile, with avatar: UIImage)
}

class ProfileViewController: UIViewController {
    //MARK: - property
    var presenter: ProfilePresenterProtocol?
    private lazy var profileView = ProfileView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.customBackground
        self.navigationItem.hidesBackButton = true
        profileView.delegate = self
        presenter?.viewControllerDidLoad()
        setupLayout()
    }
}
//MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    func showUserData(user: UserProfile, with avatar: UIImage) {
        DispatchQueue.main.async {
            self.profileView.updateView(with: user, with: avatar)
        }
    }
    func setupLayout() {
        setupProfileView()
    }
    func setupProfileView() {
        self.view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: self.view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
//MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func ratedMovieButtonDidTapped() {
        presenter?.didRatedMoviesButtonTapped()
    }
    func logoutButtunDidTapped() {
        presenter?.didLogoutButtonTapped()
    }
}
