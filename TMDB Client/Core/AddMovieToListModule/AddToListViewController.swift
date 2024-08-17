//
//  AddToListViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.08.2024.
//

import UIKit

protocol AddToListViewProtocol: AnyObject {
    
}

class AddToListViewController: UIViewController {
    //MARK: - property
    var persenter: AddToListPresenterProtocol?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}
//MARK: - AddToListViewProtocol
extension AddToListViewController: AddToListViewProtocol {
    
}
//MARK: - setup layout
private extension AddToListViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor.customBackground
    }
}
