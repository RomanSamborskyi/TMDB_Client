//
//  MovieDetailsView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


protocol MovieDetailsViewDelegate: AnyObject {
    func didMovieAddedToWatchList()
}

class MovieDetailsView: UIView {

    //MARK: - property
    weak var delegate: MovieDetailsViewDelegate?
    private lazy var posterView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var addToWatchlistButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func updateView(with: Movie, poster: UIImage) {
        self.posterView.image = poster
        self.movieTitleLabel.text = with.title ?? ""
        
        if with.isFavorite ?? false {
            guard let resizedImage = UIImage(systemName: "bookmark.fill") else { return }
            let image = resizedImage.resized(to: CGSize(width: 35, height: 35))?.withTintColor(.red)
            self.addToWatchlistButton.setImage(image, for: .normal)
            self.layoutIfNeeded()
        } else {
            guard let resizedImage = UIImage(systemName: "bookmark") else { return }
            let image = resizedImage.resized(to: CGSize(width: 35, height: 35))?.withTintColor(.white)
            self.addToWatchlistButton.setImage(image, for: .normal)
            self.layoutIfNeeded()
        }
    }
}
//MARK: - UI layout
private extension MovieDetailsView {
    func setupLayout() {
        setupPosterView()
        setupTitleLabel()
        setupButtons()
    }
    func setupButtons() {
        self.addSubview(addToWatchlistButton)
        addToWatchlistButton.translatesAutoresizingMaskIntoConstraints = false
        addToWatchlistButton.addTarget(self, action: #selector(saveToWatchlist), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addToWatchlistButton.topAnchor.constraint(equalTo: self.topAnchor),
            addToWatchlistButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    func setupPosterView() {
        self.addSubview(posterView)
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.layer.cornerRadius = 25
        posterView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            posterView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            posterView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            posterView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.7),
        ])
    }
    func setupTitleLabel() {
        self.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        movieTitleLabel.textColor = .white
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.numberOfLines = 3
        movieTitleLabel.minimumScaleFactor = 0.6
        movieTitleLabel.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 20),
            movieTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
extension MovieDetailsView {
    @objc func saveToWatchlist(selector: Selector) {
        DispatchQueue.main.async {
            self.delegate?.didMovieAddedToWatchList()
            guard let resizedImage = UIImage(systemName: "bookmark.fill") else { return }
            let image = resizedImage.resized(to: CGSize(width: 35, height: 35))?.withTintColor(.red)
            self.addToWatchlistButton.setImage(image, for: .normal)
            self.layoutIfNeeded()
        }
    }
}
