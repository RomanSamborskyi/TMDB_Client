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
    private lazy var activityView = ActivityView()
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
        activityViewSetup()
    }
    func setupAddListView() {
        self.view.addSubview(addListView)
        addListView.translatesAutoresizingMaskIntoConstraints = false
        addListView.delegate = self
        
        NSLayoutConstraint.activate([
            addListView.topAnchor.constraint(equalTo: self.view.topAnchor),
            addListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            addListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            addListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    func activityViewSetup() {
        self.view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.isHidden = true
        
        NSLayoutConstraint.activate([
            activityView.topAnchor.constraint(equalTo: self.view.topAnchor),
            activityView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            activityView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            activityView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
//MARK: - AddListViewProtocol
extension AddListViewController: AddListViewProtocol {
    
}
//MARK: - AddListViewDelegate
extension AddListViewController: AddListViewDelegate {
    func didCreateButtonPressed(with title: String, _ description: String) {
        presenter?.createList(with: title, description)
        self.presenter?.haptic.tacticFeddback(style: .light)
        self.activityView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.dismiss(animated: true)
            self?.presenter?.haptic.tacticNotification(style: .success)
        }
    }
}
