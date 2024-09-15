//
//  AddToExistListViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 04.09.2024.
//

import UIKit


protocol AddToExistListViewProtocol: AnyObject {
    
}

class AddToExistListViewController: UIViewController {
    //MARK: - property
    var presenter: AddToExiistListPresenterProtocol?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}
//MARK: - AddToExistListProtocol
extension AddToExistListViewController: AddToExistListViewProtocol {
    
}
//MARK: - setup layout
private extension AddToExistListViewController {
    func setupLayout() {
        self.view.backgroundColor = .customBackground
    }
}
