//
//  WelcomeViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    
}

class ProfileViewController: UIViewController {

    var presenter: ProfilePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
    }
}
//MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    
}
