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
            stateSwitcher()
        }
    }
    private lazy var tableViewCell: UITableView = {
        let tableView = UITableView()
        tableView.register(ListsLoadingTableViewCell.self, forCellReuseIdentifier: ListsLoadingTableViewCell.identifier)
        tableView.register(ListsTableViewCell.self, forCellReuseIdentifier: ListsTableViewCell.identifier)
        return tableView
    }()
    private lazy var emptyListView = EmptyView(imageName: "list.bullet.clipboard.fill", title: "The list is empty")
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
        
        setupViews()
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
        switch loadingState {
        case .loading:
            self.emptyListView.removeFromSuperview()
            tableViewCell.isHidden = false
            setupCollectionView()
        case .loaded:
            self.emptyListView.removeFromSuperview()
            tableViewCell.isHidden = false
            setupCollectionView()
        case .empty:
            tableViewCell.isHidden = true
            setupEmptyListView()
        }
        updateLayoutIfNeeded()
    }
    func stateSwitcher() {
        if !lists.isEmpty {
            self.loadingState = .loaded
            setupViews()
        } else if lists.count == 0 {
            self.loadingState = .empty
            setupViews()
        }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.lists = lists
        }
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch loadingState {
        case .loading:
            return 3
        case .loaded:
            return self.lists.count
        case .empty:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch loadingState {
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: ListsLoadingTableViewCell.identifier, for: indexPath) as! ListsLoadingTableViewCell
            return cell
        case .loaded:
            let cell = tableView.dequeueReusableCell(withIdentifier: ListsTableViewCell.identifier, for: indexPath) as! ListsTableViewCell
            cell.backgroundColor = UIColor.customBackground
            let item = self.lists[indexPath.row]
            cell.updateCell(with: item)
            return cell
        case .empty:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch loadingState {
        case .loading:
            break
        case .loaded:
            let item = self.lists[indexPath.row]
            self.presenter?.didListsSelected(list: item.id ?? 0)
        case .empty:
            break
        }
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

