//
//  WatchListViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchlistViewProtocol: AnyObject {
    func show(movies: [Movie], posters: [Int : UIImage])
}

class WatchlistViewController: UIViewController {
    //MARK: - property
    var presenter: WatchlistPresenterProtocol?
    private lazy var movies: [Movie] = [] {
        didSet {
            stateSwither()
        }
    }
    private lazy var posters: [Int : UIImage] = [:]
    private lazy var movieCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.height / 3.7)
        var cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(ListsLoadingCollectionViewCell.self, forCellWithReuseIdentifier: ListsLoadingCollectionViewCell.identifier)
        cell.register(MovieToWatchCollectionViewCell.self, forCellWithReuseIdentifier: MovieToWatchCollectionViewCell.identifier)
        return cell
        
    }()
    private lazy var emptyListView = EmptyView(imageName: "list.bullet.clipboard.fill", title: "The list is empty")
    private var loadingState: LoadingState = .loading
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewControllerDidLoad()
        presenter?.viewControllerWillAppear()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewControllerWillAppear()
    }
}
//MARK: - UI layout
private extension WatchlistViewController {
    func setupLayout() {
        self.navigationItem.title = "Watchlist"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor.customBackground
        
        movieCollection.dataSource = self
        movieCollection.delegate = self
        setupViews()
    }
    func setupViews() {
        switch loadingState {
        case .loading:
            self.emptyListView.removeFromSuperview()
            movieCollection.isHidden = false
            setupCollectionView()
        case .loaded:
            self.emptyListView.removeFromSuperview()
            movieCollection.isHidden = false
            setupCollectionView()
        case .empty:
            movieCollection.isHidden = true
            setupEmptyListView()
        }
    }
    func stateSwither() {
        if !movies.isEmpty {
            loadingState = .loaded
            setupViews()
        } else if movies.count == 0 {
            loadingState = .empty
            setupViews()
        }
    }
    func setupCollectionView() {
        self.view.addSubview(movieCollection)
        movieCollection.translatesAutoresizingMaskIntoConstraints = false
        movieCollection.backgroundColor = UIColor.customBackground
    
        NSLayoutConstraint.activate([
            movieCollection.topAnchor.constraint(equalTo: self.view.topAnchor),
            movieCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            movieCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            movieCollection.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            movieCollection.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            movieCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
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
}
//MARK: - WatchlistViewProtocol
extension WatchlistViewController: WatchlistViewProtocol {
    func show(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.movies = movies
            self.posters.merge(posters, uniquingKeysWith: { image, _ in image})
            self.movieCollection.reloadData()
        }
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension WatchlistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieToWatchCollectionViewCell.identifier, for: indexPath) as! MovieToWatchCollectionViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            cell.backgroundColor = .black.withAlphaComponent(0.4)
            cell.actionButtons = self
            let item = self.movies[indexPath.row]
            cell.movie = item
            if let posterImage = self.posters[item.id ?? 0] {
                cell.poster = posterImage
            }
            return cell
        case .empty:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.movies[indexPath.row]
        guard let poster = self.posters[item.id ?? 0] else { return }
        presenter?.didMovieSelected(movie: item.id ?? 0, poster: poster)
    }
}
extension WatchlistViewController: MovieToWatchCellDelegate {
    func didFavoriteButtonPressed(movieId: Int) {
        self.presenter?.didAddToFavoriteButtonPressed(for: movieId)
        self.presenter?.haptic.tacticNotification(style: .success)
    }
    func didAddToListButtonPressed(movieId: Int) {
        self.presenter?.haptic.tacticFeddback(style: .light)
        presenter?.addMovieTolist(with: movieId)
    }
}
