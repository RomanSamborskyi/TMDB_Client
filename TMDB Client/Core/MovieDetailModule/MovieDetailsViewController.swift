//
//  MovieDetailsViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit

protocol MovieDetailsViewProtocol: AnyObject {
    func show(movie: Movie, poster: UIImage)
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
        super.viewDidLoad()
        presenter?.viewControllerDidLoad()
        setupLayout()
    }
}
//MARK: - UI layout
private extension MovieDetailsViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor.customBackground
        self.detailView.delegate = self
        setupScrollView()
        setupDetailsView()
    }
    func setupScrollView() {
        let margins = self.view.layoutMarginsGuide
        self.view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: margins.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    func setupDetailsView() {
        self.view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: scroll.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            detailView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            detailView.heightAnchor.constraint(equalTo: scroll.heightAnchor),
            detailView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
        ])
    }
}
//MARK: - MovieDetailsViewProtocol
extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func show(movie: Movie, poster: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.detailView.updateView(with: movie, poster: poster)
        }
    }
}
//MARK: - MovieDetailsView delegate
extension MovieDetailsViewController: MovieDetailsViewDelegate {
    func didMovieAddedToWatchList() {
        presenter?.didMovieAddedToWatchlist()
    }
}
