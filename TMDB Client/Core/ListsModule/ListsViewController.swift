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
    private lazy var collectionCell: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 5.5)
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(ListsCollectionViewCell.self, forCellWithReuseIdentifier: ListsCollectionViewCell.identifier)
        return cell
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
        
        collectionCell.delegate = self
        collectionCell.dataSource = self
    }
    func setupCollectionView() {
        self.view.addSubview(collectionCell)
        collectionCell.translatesAutoresizingMaskIntoConstraints = false
        collectionCell.backgroundColor = UIColor.customBackground
        
        NSLayoutConstraint.activate([
            collectionCell.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionCell.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionCell.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionCell.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
//MARK: - ListsViewControllerProtocol
extension ListsViewController: ListsViewControllerProtocol {
    func show(lists: [List]) {
        DispatchQueue.main.async { [weak self] in
            self?.lists = lists
            self?.collectionCell.reloadData()
        }
    }
}
//MARK: -
extension ListsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListsCollectionViewCell.identifier, for: indexPath) as! ListsCollectionViewCell
        cell.list = self.lists[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.lists[indexPath.row]
        self.presenter?.didListsSelected(list: item.id ?? 0)
    }
}
