//
//  RatedMoviesViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit

protocol RatedMoviesViewProtocol: AnyObject {
    func show(movies: [Movie], posters: [Int : UIImage], isFetched: Bool)
}

class RatedMoviesViewController: UIViewController {
    //MARK: - property
    var presenter: RatedMoviesPresenterProtocol?
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
    private lazy var emptyListView = ListsEmptyView()
    private lazy var activityView = ActivityView()
    private lazy var isFetched: Bool = false
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewControllerDidLoad()
        setupLayout()
    }
}
//MARK: - RatedMoviesViewProtocol
extension RatedMoviesViewController: RatedMoviesViewProtocol {
    func show(movies: [Movie], posters: [Int : UIImage], isFetched: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.movies = movies
            self.posters.merge(posters) { image, _ in image }
            if isFetched && movies.count > 0 {
                self.isFetched = true
                activityView.removeFromSuperview()
                movieCollection.isHidden = false
                setupCollectionView()
            }
            self.movieCollection.reloadData()
        }
    }
}
//MARK: - setup layout
private extension RatedMoviesViewController {
    func setupLayout() {
        self.navigationItem.title = "Rated movies"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor.customBackground
        
        movieCollection.dataSource = self
        movieCollection.delegate = self
        
        if movies.count > 0 || isFetched == false {
            setupActivityView()
            self.view.layoutIfNeeded()
        }
    }
    func setupViews() {
        if movies.count > 0 {
            self.emptyListView.removeFromSuperview()
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
extension RatedMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        presenter?.didMovieSelected(id: item.id ?? 0, poster: poster)
    }
}
extension RatedMoviesViewController: MovieToWatchCellDelegate {
    func didFavoriteButtonPressed(movieId: Int) {
       
    }
    func didAddToListButtonPressed() {
       
    }
}
