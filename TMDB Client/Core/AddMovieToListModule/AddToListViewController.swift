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
    private lazy var textFieldView = TextFieldView()
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
        
        setupTextFieldView()
    }
    func setupTextFieldView() {
        self.view.addSubview(textFieldView)
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: self.view.topAnchor),
            textFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
