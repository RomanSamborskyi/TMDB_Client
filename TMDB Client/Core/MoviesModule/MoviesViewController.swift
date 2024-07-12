//
//  MoviesViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 11.07.2024.
//

import UIKit

protocol MovieViewProtocol: AnyObject {
    
}

class MoviesViewController: UIViewController {
    //MARK: - property
    var presenter: MoviePresenterProtocol?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.customBackground
        setupLayout()
    }
}
//MARK: - UI layout
private extension MoviesViewController {
    func setupLayout() {
        
    }
}
//MARK: - MovieViewProtocol
extension MoviesViewController: MovieViewProtocol {
    
}
