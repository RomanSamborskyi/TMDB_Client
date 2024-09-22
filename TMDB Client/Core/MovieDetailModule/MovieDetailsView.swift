//
//  MovieDetailsView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


protocol MovieDetailsViewDelegate: AnyObject {
    func didMovieAddedToWatchList()
    func didMovieAddedToFavorite()
    func didMovieAddedToList()
    func firstStarPressed()
    func secondStarPressed()
    func thirdStarPressed()
    func fourthStarPressed()
    func fifthStarPressed()
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
    private lazy var moviesGenreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var moviesAdditionalInfoLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var overviewTextLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var addToWatchlistButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private lazy var addToFavoriteButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private lazy var addToListButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private lazy var rateButtonsView = MovieRateView()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func updateView(with: MovieDetail, poster: UIImage) {
        self.posterView.image = poster
        self.movieTitleLabel.text = with.title ?? ""
        self.moviesGenreLabel.text = with.genres?.map { genre in
            genre.name
        }
        .joined(separator: " • ")
        
        self.moviesAdditionalInfoLabel.text = Array(arrayLiteral: "\(with.runtime ?? 0) min", with.releaseDate ?? "")
            .joined(separator: " • ")
        self.overviewLabel.text = with.overview ?? ""
        if with.watchList ?? false {
            setColorForAddToWatchlist(color: .red)
        } else {
            setColorForAddToWatchlist(color: .white)
        }
        if with.favorite ?? false {
            setColorForFavoriteButton(color: .systemPink)
        } else {
            setColorForFavoriteButton(color: .white)
        }
        self.rateButtonsView.setColorForRateButtons(rate: with.myRate ?? 0)
    }
}
//MARK: - UI layout
private extension MovieDetailsView {
    func setupLayout() {
        setupPosterView()
        setupTitleLabel()
        setupGenreLabel()
        setupAdditionalInfoLabel()
        setupRateView()
        setupAddToWatchlistButton()
        setupOverviewTextLabel()
        setupOverviewLabel()
        setupAddToFavoriteButton()
        setupAddToListButton()
    }
    func setupRateView() {
        self.addSubview(rateButtonsView)
        rateButtonsView.translatesAutoresizingMaskIntoConstraints = false
        rateButtonsView.backgroundColor = UIColor.customBackground
        rateButtonsView.delegate = self
        
        NSLayoutConstraint.activate([
            rateButtonsView.topAnchor.constraint(equalTo: moviesAdditionalInfoLabel.bottomAnchor, constant: 20),
            rateButtonsView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rateButtonsView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    func setupOverviewTextLabel() {
        self.addSubview(overviewTextLabel)
        overviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewTextLabel.font = .systemFont(ofSize: 20, weight: .bold)
        overviewTextLabel.textColor = .white
        overviewTextLabel.text = "Overview"
        
        NSLayoutConstraint.activate([
            overviewTextLabel.topAnchor.constraint(equalTo: addToWatchlistButton.bottomAnchor, constant: 30),
            overviewTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
    }
    func setupOverviewLabel() {
        self.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.font = .systemFont(ofSize: 15, weight: .regular)
        overviewLabel.textColor = .white
        overviewLabel.textAlignment = .left
        overviewLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: overviewTextLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    func setupAddToWatchlistButton() {
        self.addSubview(addToWatchlistButton)
        addToWatchlistButton.translatesAutoresizingMaskIntoConstraints = false
        addToWatchlistButton.addTarget(self, action: #selector(saveToWatchlist), for: .touchUpInside)
        addToWatchlistButton.clipsToBounds = true
        addToWatchlistButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        addToWatchlistButton.titleLabel?.textColor = .white
        addToWatchlistButton.layer.cornerRadius = 10
        addToWatchlistButton.layer.borderWidth = 2
        addToWatchlistButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            addToWatchlistButton.topAnchor.constraint(equalTo: rateButtonsView.bottomAnchor, constant: 20),
            addToWatchlistButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            addToWatchlistButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.2),
            addToWatchlistButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.055),
        ])
    }
    func setupAddToFavoriteButton() {
        self.addSubview(addToFavoriteButton)
        addToFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        addToFavoriteButton.addTarget(self, action: #selector(addMovieToFavorite), for: .touchUpInside)
        addToFavoriteButton.clipsToBounds = true
        addToFavoriteButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        addToFavoriteButton.titleLabel?.textColor = .white
        addToFavoriteButton.layer.cornerRadius = 10
        addToFavoriteButton.layer.borderWidth = 2
        addToFavoriteButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            addToFavoriteButton.topAnchor.constraint(equalTo: rateButtonsView.bottomAnchor, constant: 20),
            addToFavoriteButton.leadingAnchor.constraint(equalTo: addToWatchlistButton.trailingAnchor, constant: 10),
           // addToFavoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            addToFavoriteButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.2),
            addToFavoriteButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.055),
        ])
    }
    func setupAddToListButton() {
        self.addSubview(addToListButton)
        addToListButton.translatesAutoresizingMaskIntoConstraints = false
        addToListButton.addTarget(self, action: #selector(addMovieToList), for: .touchUpInside)
        addToListButton.clipsToBounds = true
        addToListButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        addToListButton.titleLabel?.textColor = .white
        addToListButton.layer.cornerRadius = 10
        addToListButton.layer.borderWidth = 2
        addToListButton.layer.borderColor = UIColor.white.cgColor
        addToListButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        addToListButton.tintColor = .white
        
        NSLayoutConstraint.activate([
            addToListButton.topAnchor.constraint(equalTo: rateButtonsView.bottomAnchor, constant: 20),
            addToListButton.leadingAnchor.constraint(equalTo: self.addToFavoriteButton.trailingAnchor, constant: 10),
            addToListButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.2),
            addToListButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.055),
            addToListButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    func setupPosterView() {
        self.addSubview(posterView)
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.layer.cornerRadius = 25
        posterView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: self.topAnchor),
            posterView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            posterView.widthAnchor.constraint(equalTo: self.widthAnchor),
            posterView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1.4),
            
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
    func setupGenreLabel() {
        self.addSubview(moviesGenreLabel)
        moviesGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        moviesGenreLabel.font = .systemFont(ofSize: 18, weight: .medium)
        moviesGenreLabel.textColor = .white
        moviesGenreLabel.textAlignment = .center
        moviesGenreLabel.numberOfLines = 3
        moviesGenreLabel.minimumScaleFactor = 0.6
        moviesGenreLabel.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            moviesGenreLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10),
            moviesGenreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            moviesGenreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    func setupAdditionalInfoLabel() {
        self.addSubview(moviesAdditionalInfoLabel)
        moviesAdditionalInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        moviesAdditionalInfoLabel.font = .systemFont(ofSize: 18, weight: .medium)
        moviesAdditionalInfoLabel.textColor = .white
        moviesAdditionalInfoLabel.textAlignment = .center
        moviesAdditionalInfoLabel.numberOfLines = 3
        moviesAdditionalInfoLabel.minimumScaleFactor = 0.6
        moviesAdditionalInfoLabel.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            moviesAdditionalInfoLabel.topAnchor.constraint(equalTo: moviesGenreLabel.bottomAnchor, constant: 10),
            moviesAdditionalInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            moviesAdditionalInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    func setColorForAddToWatchlist(color: UIColor) {
        guard let resizedImage = UIImage(systemName: "bookmark.fill") else { return }
        let image = resizedImage.resized(to: CGSize(width: 35, height: 35))?.withTintColor(color)
        addToWatchlistButton.setImage(image, for: .normal)
        self.layoutIfNeeded()
    }
    func setColorForFavoriteButton(color: UIColor) {
        let image = UIImage(systemName: "heart.fill")?.resized(to: CGSize(width: 35, height: 35))?.withTintColor(color)
        self.addToFavoriteButton.setImage(image, for: .normal)
        self.layoutIfNeeded()
    }
}
extension MovieDetailsView {
    @objc func saveToWatchlist(selector: Selector) {
        self.delegate?.didMovieAddedToWatchList()
        setColorForAddToWatchlist(color: .red)
    }
    @objc func addMovieToFavorite(selector: Selector) {
        self.delegate?.didMovieAddedToFavorite()
        setColorForFavoriteButton(color: .systemPink)
    }
    @objc func addMovieToList(selector: Selector) {
        self.delegate?.didMovieAddedToList()
    }
}
//MARK: - RateViewDelegate
extension MovieDetailsView: RateViewDelegate {
    func firstStarPressed() {
        self.delegate?.firstStarPressed()
    }
    func secondStarPressed() {
        self.delegate?.secondStarPressed()
    }
    func thirdStarPressed() {
        self.delegate?.thirdStarPressed()
    }
    func fourthStarPressed() {
        self.delegate?.fourthStarPressed()
    }
    func fifthStarPressed() {
        self.delegate?.fifthStarPressed()
    }
}
