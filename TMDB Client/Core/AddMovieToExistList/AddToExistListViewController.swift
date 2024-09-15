//
//  AddToExistListViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 04.09.2024.
//

import UIKit


protocol AddToExistListViewProtocol: AnyObject {
    func showLists(lists: [List])
}

class AddToExistListViewController: UIViewController {
    //MARK: - property
    var presenter: AddToExiistListPresenterProtocol?
    private lazy var mainView = AddToExistingListView()
    private lazy var alertView = AlertView(titel: "Added", imageName: "checkmark.circle")
    private var lists: [List] = []
    private lazy var tableView: UITableView = {
        let tablv = UITableView()
        tablv.register(ListsTableViewCell.self, forCellReuseIdentifier: ListsTableViewCell.identifier)
        return tablv
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewControllerDidLoad()
        setupLayout()
    }
}
//MARK: - AddToExistListProtocol
extension AddToExistListViewController: AddToExistListViewProtocol {
    func showLists(lists: [List]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.lists.append(contentsOf: lists)
            self.tableView.reloadData()
        }
    }
}
//MARK: - setup layout
private extension AddToExistListViewController {
    func setupLayout() {
        self.view.backgroundColor = .customBackground
        setupView()
        setupTableView()
    }
    func setupView() {
        self.view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .customBackground
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    func setupAlertView() {
        self.view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.clipsToBounds = true
        alertView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 150),
            alertView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension AddToExistListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListsTableViewCell.identifier, for: indexPath) as! ListsTableViewCell
        let item = self.lists[indexPath.row]
        cell.updateCell(with: item)
        cell.backgroundColor = .customBackground
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.lists[indexPath.row]
        presenter?.addMovieToExistingList(with: item.id ?? 0)
        presenter?.haptic.tacticNotification(style: .success)
        self.setupAlertView()
        self.view.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true)
        }
    }
}
