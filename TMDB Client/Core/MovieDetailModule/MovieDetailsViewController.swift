//
//  MovieDetailsViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit

protocol MovieDetailsViewProtocol: AnyObject {
    
}

class MovieDetailsViewController: UIViewController {
    //MARK: - property
    var presenter: MovieDetailsPresenterProtocol?

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
//MARK: - UI layout
private extension MovieDetailsViewController {
    
}
//MARK: - MovieDetailsViewProtocol
extension MovieDetailsViewController: MovieDetailsViewProtocol {
    
}
