//
//  SearchViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    
}

class SearchViewController: UIViewController {
    //MARK: - property
    var preseter: SearchPresenterProtocol?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        preseter?.viewDidLoad()
        setupLayout()
    }
}
//MARK: - SearchViewControllerProtocol
extension SearchViewController: SearchViewControllerProtocol {
    
}
//MARK: - UI layout
private extension SearchViewController {
    func setupLayout() {
        
    }
}
