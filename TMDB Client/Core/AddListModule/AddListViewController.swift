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
    private lazy var addListView = AddListView()
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
        setupAddListView()
    }
    func setupAddListView() {
        self.view.addSubview(addListView)
        addListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addListView.topAnchor.constraint(equalTo: self.view.topAnchor),
            addListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            addListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            addListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
//MARK: - AddListViewProtocol
extension AddListViewController: AddListViewProtocol {
    
}
