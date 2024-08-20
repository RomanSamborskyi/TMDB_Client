//
//  AddListViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 20.08.2024.
//

import UIKit

protocol AddListViewProtocol: AnyObject {
    
}

class AddListViewController: UIViewController {
    //MARK: - property
    var presenter: AddListPresenter?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.customBackground
        setupLayout()
    }
}
//MARK: - setup layout
private extension AddListViewController {
    func setupLayout() {
        
    }
}
//MARK: - AddListViewProtocol
extension AddListViewController: AddListViewProtocol {
    
}
