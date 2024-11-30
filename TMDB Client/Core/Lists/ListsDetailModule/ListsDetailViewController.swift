//
//  ListsDetailViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import UIKit

protocol ListsDetailViewProtocol: AnyObject {
    func showListDetail(list: ListDetail, posters: [Int : UIImage])
}

class ListsDetailViewController: UIViewController {

    //MARK: - property
    var presenter: ListsDetailPresenterProtocol?
    private lazy var posters: [Int : UIImage] = [:]
    private lazy var movies: [Movie] = [] {
        didSet {
            stateSwitcher()
        }
    }
    private lazy var collection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15 , height: UIScreen.main.bounds.height / 3.7)
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(ListsLoadingCollectionViewCell.self, forCellWithReuseIdentifier: ListsLoadingCollectionViewCell.identifier)
        cell.register(ListsResultCell.self, forCellWithReuseIdentifier: ListsResultCell.identifier)
        return cell
    }()
    private lazy var emptyListView = EmptyView(imageName: "list.bullet.clipboard.fill", title: "The list is empty")
    private lazy var loadingState: LoadingState = .loading
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.didViewControllerLoad()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewControllerWillAppear()
    }
}
//MARK: - ListsViewProtocol
extension ListsDetailViewController: ListsDetailViewProtocol {
    func showListDetail(list: ListDetail, posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            self?.posters = posters
            self?.movies = list.items ?? []
            self?.navigationItem.title = list.name
            self?.collection.reloadData()
        }
    }
}
//MARK: - setup layout
private extension ListsDetailViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor.customBackground
        self.collection.delegate = self
        self.collection.dataSource = self
        
        setupViews()
        setupNavigationBar()
    }
    func setupViews() {
        switch loadingState {
        case .loading:
            self.emptyListView.removeFromSuperview()
            collection.isHidden = false
            setupCollectionView()
        case .loaded:
            self.emptyListView.removeFromSuperview()
            collection.isHidden = false
            setupCollectionView()
        case .empty:
            collection.isHidden = true
            setupEmptyListView()
        }
    }
    func stateSwitcher() {
        if !movies.isEmpty {
            self.loadingState = .loaded
            setupViews()
        } else if movies.count == 0 {
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
    func setupNavigationBar() {
        let barButton = UIBarButtonItem(title: "Add Movie +", style: .plain, target: self, action: #selector(addMovie))
        barButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = barButton
    }
    func setupCollectionView() {
        self.view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.customBackground
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: self.view.topAnchor),
            collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    @objc func addMovie(selector: Selector) {
        presenter?.didAddMovieToList(movies: self.movies)
    }
}
//MARK: - UICollectionDataSource & Delegate
extension ListsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch loadingState {
        case .loading:
            return 4
        case .loaded:
            return self.movies.count
        case .empty:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch loadingState {
        case .loading:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListsLoadingCollectionViewCell.identifier, for: indexPath) as! ListsLoadingCollectionViewCell
            cell.layer.cornerRadius = 15
            
            return cell
        case .loaded:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListsResultCell.identifier, for: indexPath) as! ListsResultCell
            let item = self.movies[indexPath.row]
            cell.movie = item
            cell.poster = self.posters[item.id ?? 0]
            cell.buttonStyle = .delete
            cell.delegate = self
            cell.clipsToBounds = true
            cell.backgroundColor = .black.withAlphaComponent(0.4)
            cell.layer.cornerRadius = 15
            return cell
        case .empty:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.movies[indexPath.row]
        guard let itemPoster = self.posters[item.id ?? 0] else {
            return
        }
        presenter?.didMovieSelected(movie: item, poster: itemPoster)
    }
}
//MARK: - ListsResult cell delegate
extension ListsDetailViewController: ListsResultCellDelegate {
    func didButtonTapped(for id: Int) {
        presenter?.deleteMovieFromList(with: id)
    }
}
