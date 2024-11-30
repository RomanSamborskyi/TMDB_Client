//
//  ListsViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 13.07.2024.
//

import UIKit


protocol ListsViewControllerProtocol: AnyObject {
    func show(lists: [List])
    func updateLayoutIfNeeded()
}

class ListsViewController: UIViewController {

    //MARK: - property
    var presenter: ListsPresenterProtocol?
    private var lists: [List] = [] {
        didSet {
            setupViews()
        }
    }
    private lazy var tableViewCell: UITableView = {
        let tableView = UITableView()
        tableView.register(ListsTableViewCell.self, forCellReuseIdentifier: ListsTableViewCell.identifier)
        return tableView
    }()
    private lazy var emptyListView = EmptyView(imageName: "list.bullet.clipboard.fill", title: "The list is empty")
    private lazy var activityView = ActivityView()
    private lazy var loadingState: LoadingState = .loading
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customBackground
        setupLayout()
        setupNavigationBarItems()
    }
    override func viewDidAppear(_ animated: Bool) {
        presenter?.viewControllerDidLoad()
        updateLayoutIfNeeded()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
}
//MARK: - UI layout
private extension ListsViewController {
    func setupLayout() {
        self.navigationItem.title = "Lists"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableViewCell.delegate = self
        tableViewCell.dataSource = self
        
        setupActivityView()
    }
    func setupNavigationBarItems() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(addListButton))
        barButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = barButton
    }
    @objc func addListButton(selector: Selector) {
        presenter?.didAddListButtonPressed()
    }
    func setupViews() {
        if lists.count > 0 {
            self.emptyListView.removeFromSuperview()
            self.activityView.removeFromSuperview()
            tableViewCell.isHidden = false
            setupCollectionView()
        } else {
            tableViewCell.isHidden = true
            activityView.isHidden = true
            setupEmptyListView()
            self.view.layoutIfNeeded()
        }
    }
    func setupActivityView() {
        self.view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            activityView.widthAnchor.constraint(equalToConstant: 150),
            activityView.heightAnchor.constraint(equalToConstant: 150),
            activityView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    func setupEmptyListView() {
        self.view.addSubview(emptyListView)
        emptyListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyListView.topAnchor.constraint(equalTo: self.view.topAnchor),
            emptyListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            emptyListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            emptyListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
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
    func updateLayoutIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.tableViewCell.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    func show(lists: [List]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.lists = lists
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = self.lists[indexPath.row]
        
        let clear = UIContextualAction(style: .normal, title: "Clear") { action, view, complition in
            self.presenter?.clearList(with: item.id ?? 0)
            complition(true)
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, complition in
            self.presenter?.deleteList(with: item.id ?? 0)
            complition(true)
        }
        clear.backgroundColor = .systemBlue
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete, clear])
        
        tableView.reloadData()
        
        return swipeConfiguration
    }
}

