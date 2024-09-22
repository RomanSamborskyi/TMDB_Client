//
//  MoviesCastViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastViewProtocol: AnyObject {
    
}
 
class MoviesCastViewController: UIViewController {
    //MARK: - property
    var presenter: MoviesCastPresenterProtocol?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}
//MARK: - MoviesCastViewProtocol
extension MoviesCastViewController: MoviesCastViewProtocol {
    
}
//MARK: - setup layout
private extension MoviesCastViewController {
    func setupLayout() {
        
    }
}
