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
    private lazy var movies: [Movie] = []
    private lazy var posters: [Int : UIImage] = [:]
    private lazy var scroll: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var movieCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.height / 3.7)
        var cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(MovieToWatchCollectionViewCell.self, forCellWithReuseIdentifier: MovieToWatchCollectionViewCell.identifier)
        return cell
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewControllerDidLoad()
        setupLayout()
        
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
        setupScrollView()
        setupCollectionView()
    }
    func setupScrollView() {
        self.view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: margins.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
    }
    func setupCollectionView() {
        self.scroll.addSubview(movieCollection)
        movieCollection.translatesAutoresizingMaskIntoConstraints = false
        movieCollection.backgroundColor = UIColor.customBackground
        
        NSLayoutConstraint.activate([
            movieCollection.topAnchor.constraint(equalTo: scroll.topAnchor),
            movieCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            movieCollection.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            movieCollection.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            movieCollection.heightAnchor.constraint(equalTo: scroll.heightAnchor),
            movieCollection.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
        ])
    }
}
//MARK: - WatchlistViewProtocol
extension WatchlistViewController: WatchlistViewProtocol {
    func show(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            self?.movies.append(contentsOf: movies)
            self?.posters.merge(posters, uniquingKeysWith: { image, _ in image})
            self?.movieCollection.reloadData()
        }
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension WatchlistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        presenter?.didMovieSelected(movie: item.id ?? 0, poster: poster)
    }
}
extension WatchlistViewController: MovieToWatchCellDelegate {
    func didRateButtonPressed() {
        print(#function)
    }
    
    func didFavoriteButtonPressed() {
        print(#function)
    }
    
    func didAddToListButtonPressed() {
        print(#function)
    }
}
