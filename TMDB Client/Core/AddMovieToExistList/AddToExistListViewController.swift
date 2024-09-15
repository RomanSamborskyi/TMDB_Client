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
    private lazy var mainView = AddToExistingListView()
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
        setupView()
    }
    func setupView() {
        self.view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
