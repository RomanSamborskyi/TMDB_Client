//
//  RatedMoviesViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit

protocol FavoriteMoviesViewProtocol: AnyObject {
    func show(movies: [Movie], posters: [Int : UIImage])
}

class FavoriteMoviesViewController: UIViewController {
    //MARK: - property
    var presenter: FavoriteMoviesPresenterProtocol?
    private lazy var movies: [Movie] = [] {
        didSet {
            setupViews()
        }
    }
    private lazy var posters: [Int : UIImage] = [:]
    private lazy var movieCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.height / 3.7)
        var cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(MovieToWatchCollectionViewCell.self, forCellWithReuseIdentifier: MovieToWatchCollectionViewCell.identifier)
        return cell
    }()
    private lazy var emptyListView = EmptyView(imageName: "list.bullet.clipboard.fill", title: "The list is empty")
    private lazy var activityView = ActivityView()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewControllerDidLoad()
        setupLayout()
    }
}
//MARK: - RatedMoviesViewProtocol
extension FavoriteMoviesViewController: FavoriteMoviesViewProtocol {
    func show(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.movies = movies
            self.posters.merge(posters) { image, _ in image }
            self.movieCollection.reloadData()
        }
    }
}
//MARK: - setup layout
private extension FavoriteMoviesViewController {
    func setupLayout() {
        self.navigationItem.title = "Favorite movies"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor.customBackground
        
        movieCollection.dataSource = self
        movieCollection.delegate = self
        setupActivityView()
    }
    func setupViews() {
        if movies.count > 0 {
            self.emptyListView.removeFromSuperview()
            activityView.removeFromSuperview()
            movieCollection.isHidden = false
            setupCollectionView()
        } else if movies.count == 0 {
            movieCollection.isHidden = true
            activityView.isHidden = true
            self.setupEmptyListView()
            self.view.layoutIfNeeded()
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
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FavoriteMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.movies[indexPath.row]
        guard let poster = self.posters[item.id ?? 0] else { return }
        presenter?.didMovieSelected(with: item.id ?? 0, poster: poster)
    }
}
extension FavoriteMoviesViewController: MovieToWatchCellDelegate {
    func didFavoriteButtonPressed(movieId: Int) {
       //Movie allready in favorites
    }
    func didAddToListButtonPressed(movieId: Int) {
        presenter?.addMovieToExistList(with: movieId)
    }
}
