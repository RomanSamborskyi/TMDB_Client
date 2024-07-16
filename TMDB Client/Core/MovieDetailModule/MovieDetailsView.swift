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
        return createButton(with: "bookmark", with: .white)
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
            addToWatchlistButton.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 30),
            addToWatchlistButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            addToWatchlistButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
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
        delegate?.didMovieAddedToWatchList()
    }
}
private extension MovieDetailsView {
    /// Function to creat button in MovieDetailView. It return a button with specific image labele, with background and color .buttonColor and corner radius = 30
    func createButton(with label: String, with color: UIColor) -> UIButton {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if let originalImage = UIImage(systemName: label) {
            let resizedImage = originalImage.resized(to: CGSize(width: 35, height: 35))?.withTintColor(color)
            button.setImage(resizedImage, for: .normal)
        }
        
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }
}
