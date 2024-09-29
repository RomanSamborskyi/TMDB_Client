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
}

class MovieDetailsViewController: UIViewController {
    //MARK: - property
    private lazy var cast: [Cast] = []
    private lazy var photos: [Int: UIImage] = [:]
    private lazy var reviews: [Review] = []
    private lazy var avatars: [String: UIImage] = [:]
    var presenter: MovieDetailsPresenterProtocol?
    private lazy var scroll: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var detailView = MovieDetailsView()
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
        setupReviewCollectionView()
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
          //  castCollection.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.06)
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
            reviewCollection.topAnchor.constraint(equalTo: self.castCollection.bottomAnchor),
            reviewCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 15),
            reviewCollection.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            reviewCollection.heightAnchor.constraint(equalToConstant: 210),
            reviewCollection.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.06)
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
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            let item = self.cast[indexPath.row]
            let poster = self.photos[item.id ?? 0]
            presenter?.didPersonSelected(person: item.id ?? 0, poster: poster!)
        default:
            break
        }
    }
}
