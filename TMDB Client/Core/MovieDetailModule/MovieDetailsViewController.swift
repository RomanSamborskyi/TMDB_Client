//
//  MovieDetailsViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit

protocol MovieDetailsViewProtocol: AnyObject {
    func show(movie: MovieDetail, poster: UIImage)
}

class MovieDetailsViewController: UIViewController {
    //MARK: - property
    var presenter: MovieDetailsPresenterProtocol?
    private lazy var scroll: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var detailView = MovieDetailsView()
    //MARK: - lifecycle
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        presenter?.viewControllerDidLoad()
        setupLayout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
            detailView.heightAnchor.constraint(equalTo: scroll.heightAnchor),
            detailView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -UIScreen.main.bounds.height / 6),
        ])
    }
}
//MARK: - MovieDetailsViewProtocol
extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func show(movie: MovieDetail, poster: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.detailView.updateView(with: movie, poster: poster)
        }
    }
}
//MARK: - MovieDetailsView delegate
extension MovieDetailsViewController: MovieDetailsViewDelegate {
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
