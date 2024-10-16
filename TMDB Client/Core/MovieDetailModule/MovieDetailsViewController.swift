//
//  MovieDetailsViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit

protocol MovieDetailsViewProtocol: AnyObject {
    func show(movie: MovieDetail, poster: UIImage)
    func showCrew(crew: [Cast], photo: [Int : UIImage])
    func showReviews(reviews: [Review], avatar: [String : UIImage])
    func showSimilarMovies(movies: [Movie], posters: [Int : UIImage])
}

class MovieDetailsViewController: UIViewController {
    //MARK: - property
    private lazy var cast: [Cast] = []
    private lazy var photos: [Int: UIImage] = [:]
    private lazy var reviews: [Review] = [] {
        didSet {
            setupReviews()
        }
    }
    private lazy var avatars: [String: UIImage] = [:]
    private lazy var similarMovies: [Movie] = [] {
        didSet {
            setupSimilarMoviesView()
        }
    }
    private lazy var posters: [Int : UIImage] = [:]
    var presenter: MovieDetailsPresenterProtocol?
    private lazy var scroll: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var detailView = MovieDetailsView()
    private lazy var reviewLabelView = ReviewTextLabel(textLabel: "Reviews")
    private lazy var similarMoviesLabelView = ReviewTextLabel(textLabel: "Similar movies")
    private lazy var emptyReviewsView = EmptyView(imageName: "rectangle.and.text.magnifyingglass", title: "No reviews")
    private lazy var emptySimilarMoviesView = EmptyView(imageName: "list.bullet.clipboard.fill", title: "The list is empty")
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewControllerDidLoad()
        setupLayout()
    }
    private lazy var castCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.itemSize = CGSize(width: 75, height: 135)
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(MoviesCastCollectionView.self, forCellWithReuseIdentifier: MoviesCastCollectionView.identifier)
        return cell
    }()
    private lazy var reviewCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(MoviesReviewCollectionViewCell.self, forCellWithReuseIdentifier: MoviesReviewCollectionViewCell.identifier)
        return cell
    }()
    private lazy var similarMoviesCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = .init(width: UIScreen.main.bounds.width / 3.17, height: 190)
        flow.scrollDirection = .horizontal
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.identifire)
        return cell
    }()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
}
//MARK: - UI layout
private extension MovieDetailsViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor.customBackground
        self.detailView.delegate = self
        scroll.contentInsetAdjustmentBehavior = .never
        
        setupScrollView()
        setupDetailsView()
        setupCastCollectionView()
        setupReviewTextLabel()
        setupReviews()
        setupSimilarMoviesTextLabel()
        setupSimilarMoviesView()
    }
    func setupReviews() {
        if self.reviews.isEmpty {
            setupEmptyReviewView()
            self.view.layoutIfNeeded()
        } else {
            setupReviewCollectionView()
            reviewCollection.reloadData()
        }
    }
    func setupSimilarMoviesView() {
        if self.similarMovies.isEmpty {
            setupEmptySimilarMoviesView()
            self.view.layoutIfNeeded()
        } else {
            setupCollectionView()
            similarMoviesCollectionView.reloadData()
        }
    }
    func setupEmptySimilarMoviesView() {
        self.scroll.addSubview(emptySimilarMoviesView)
        emptySimilarMoviesView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptySimilarMoviesView.topAnchor.constraint(equalTo: similarMoviesLabelView.bottomAnchor),
            emptySimilarMoviesView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 15),
            emptySimilarMoviesView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            emptySimilarMoviesView.heightAnchor.constraint(equalToConstant: 210),
            emptySimilarMoviesView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.06),
        ])
    }
    func setupEmptyReviewView() {
        self.scroll.addSubview(emptyReviewsView)
        emptyReviewsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyReviewsView.topAnchor.constraint(equalTo: self.reviewLabelView.bottomAnchor, constant: 10),
            emptyReviewsView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 15),
            emptyReviewsView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            emptyReviewsView.heightAnchor.constraint(equalToConstant: 210),
        ])
    }
    func setupCollectionView() {
        self.scroll.addSubview(similarMoviesCollectionView)
        similarMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.dataSource = self
        similarMoviesCollectionView.backgroundColor = .customBackground
        similarMoviesCollectionView.showsHorizontalScrollIndicator = false
        similarMoviesCollectionView.tag = 2
        NSLayoutConstraint.activate([
            similarMoviesCollectionView.topAnchor.constraint(equalTo: similarMoviesLabelView.bottomAnchor),
            similarMoviesCollectionView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 15),
            similarMoviesCollectionView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            similarMoviesCollectionView.heightAnchor.constraint(equalToConstant: 200),
            similarMoviesCollectionView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.06),
        ])
    }
    func setupReviewTextLabel() {
        self.scroll.addSubview(reviewLabelView)
        reviewLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reviewLabelView.topAnchor.constraint(equalTo: castCollection.bottomAnchor, constant: 30),
            reviewLabelView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            reviewLabelView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
        ])
    }
    func setupSimilarMoviesTextLabel() {
        self.scroll.addSubview(similarMoviesLabelView)
        similarMoviesLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            similarMoviesLabelView.topAnchor.constraint(equalTo: self.reviews.isEmpty ? emptyReviewsView.bottomAnchor : reviewCollection.bottomAnchor, constant: 30),
            similarMoviesLabelView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            similarMoviesLabelView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
        ])
    }
    func setupCastCollectionView() {
        self.scroll.addSubview(castCollection)
        castCollection.translatesAutoresizingMaskIntoConstraints = false
        
        castCollection.delegate = self
        castCollection.dataSource = self
        castCollection.showsHorizontalScrollIndicator = false
        castCollection.backgroundColor = .customBackground
        castCollection.tag = 0
        
        NSLayoutConstraint.activate([
            castCollection.topAnchor.constraint(equalTo: self.detailView.bottomAnchor),
            castCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 15),
            castCollection.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            castCollection.heightAnchor.constraint(equalToConstant: 130),
        ])
    }
    func setupReviewCollectionView() {
        self.scroll.addSubview(reviewCollection)
        reviewCollection.translatesAutoresizingMaskIntoConstraints = false
        
        reviewCollection.delegate = self
        reviewCollection.dataSource = self
        reviewCollection.showsHorizontalScrollIndicator = false
        reviewCollection.backgroundColor = .customBackground
        reviewCollection.tag = 1
        
        NSLayoutConstraint.activate([
            reviewCollection.topAnchor.constraint(equalTo: self.reviewLabelView.bottomAnchor, constant: 10),
            reviewCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 15),
            reviewCollection.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            reviewCollection.heightAnchor.constraint(equalToConstant: 210),
        ])
    }
    func setupScrollView() {
        self.view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: self.view.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    func setupDetailsView() {
        self.scroll.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: scroll.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            detailView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
        ])
    }
}
//MARK: - MovieDetailsViewProtocol
extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func showSimilarMovies(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            self?.similarMovies.append(contentsOf: movies)
            self?.posters.merge(posters, uniquingKeysWith: { image, _ in image })
            self?.similarMoviesCollectionView.reloadData()
        }
    }
    func showReviews(reviews: [Review], avatar: [String : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            self?.reviews.append(contentsOf: reviews)
            self?.avatars.merge(avatar, uniquingKeysWith: { image, _ in image })
            self?.reviewCollection.reloadData()
        }
    }
    func showCrew(crew: [Cast], photo: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            self?.cast.append(contentsOf: crew)
            self?.photos.merge(photo, uniquingKeysWith: { _, image in image })
            self?.castCollection.reloadData()
        }
    }
    func show(movie: MovieDetail, poster: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.detailView.updateView(with: movie, poster: poster)
            self?.view.layoutIfNeeded()
        }
    }
}
//MARK: - MovieDetailsView delegate
extension MovieDetailsViewController: MovieDetailsViewDelegate {
    func thrillerbuttonPressed() {
        presenter?.didWatchThrillerButtonPressed()
    }
    func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    func didMovieAddedToList() {
        presenter?.didMovieAddedToList()
        presenter?.haptic.tacticNotification(style: .success)
    }
    func firstStarPressed() {
        presenter?.rateMovie(rate: 2)
        presenter?.haptic.tacticNotification(style: .success)
    }
    func secondStarPressed() {
        presenter?.rateMovie(rate: 4)
        presenter?.haptic.tacticNotification(style: .success)
    }
    func thirdStarPressed() {
        presenter?.rateMovie(rate: 6)
        presenter?.haptic.tacticNotification(style: .success)
    }
    func fourthStarPressed() {
        presenter?.rateMovie(rate: 8)
        presenter?.haptic.tacticNotification(style: .success)
    }
    func fifthStarPressed() {
        presenter?.rateMovie(rate: 10)
        presenter?.haptic.tacticNotification(style: .success)
    }
    func didMovieAddedToFavorite() {
        presenter?.didMovieAddedToFavorite()
        presenter?.haptic.tacticNotification(style: .success)
    }
    func didMovieAddedToWatchList() {
        presenter?.didMovieAddedToWatchlist()
        presenter?.haptic.tacticNotification(style: .success)
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return  self.cast.count
        case 1:
            return self.reviews.count
        case 2:
            return self.similarMovies.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCastCollectionView.identifier, for: indexPath) as! MoviesCastCollectionView
            let item = self.cast[indexPath.row]
            let poster = self.photos[item.id ?? 0]
            cell.persone = item
            cell.photo = poster
            return cell
            
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesReviewCollectionViewCell.identifier, for: indexPath) as! MoviesReviewCollectionViewCell
            let item = self.reviews[indexPath.row]
            let poster = self.avatars[item.id]
            cell.review = item
            cell.avatar = poster
            return cell
        case 2 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifire, for: indexPath) as! TopCollectionViewCell
            let item = self.similarMovies[indexPath.row]
            let poster = self.posters[item.id ?? 0]
            cell.movie = item
            cell.poster = poster
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            let item = self.cast[indexPath.row]
            guard let poster = self.photos[item.id ?? 0] else { return }
            presenter?.didPersonSelected(person: item.id ?? 0, poster: poster)
        case 1:
            break
        case 2:
            let item = self.similarMovies[indexPath.row]
            guard let poster = self.posters[item.id ?? 0] else { return }
            presenter?.didSimilarMoviesSelected(with: item.id ?? 0, poster: poster)
        default:
            break
        }
    }
}
