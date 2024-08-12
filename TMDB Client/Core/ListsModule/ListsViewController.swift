//
//  ListsViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 13.07.2024.
//

import UIKit


protocol ListsViewControllerProtocol: AnyObject {
    func show(lists: [List])
}

class ListsViewController: UIViewController {

    //MARK: - property
    var presenter: ListsPresenterProtocol?
    private var lists: [List] = []
    private lazy var tableViewCell: UITableView = {
        let tableView = UITableView()
        tableView.register(ListsTableViewCell.self, forCellReuseIdentifier: ListsTableViewCell.identifier)
        return tableView
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customBackground
        presenter?.viewControllerDidLoad()
        setupLayout()
    }
}
//MARK: - UI layout
private extension ListsViewController {
    func setupLayout() {
        setupCollectionView()
        self.navigationItem.title = "Lists"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableViewCell.delegate = self
        tableViewCell.dataSource = self
    }
    func setupCollectionView() {
        self.view.addSubview(tableViewCell)
        tableViewCell.translatesAutoresizingMaskIntoConstraints = false
        tableViewCell.backgroundColor = UIColor.customBackground
        
        NSLayoutConstraint.activate([
            tableViewCell.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableViewCell.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableViewCell.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableViewCell.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
//MARK: - ListsViewControllerProtocol
extension ListsViewController: ListsViewControllerProtocol {
    func show(lists: [List]) {
        DispatchQueue.main.async { [weak self] in
            self?.lists = lists
            self?.tableViewCell.reloadData()
        }
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListsTableViewCell.identifier, for: indexPath) as! ListsTableViewCell
        cell.backgroundColor = UIColor.customBackground
        let item = self.lists[indexPath.row]
        cell.updateCell(with: item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.lists[indexPath.row]
        self.presenter?.didListsSelected(list: item.id ?? 0)
    }
}
