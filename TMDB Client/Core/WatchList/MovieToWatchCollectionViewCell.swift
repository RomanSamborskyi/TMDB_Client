//
//  MovieToWatchCollectionViewCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit

//MARK: - MovieToWatchCollectionViewCell delegate
protocol MovieToWatchCellDelegate: AnyObject {
    func didRateButtonPressed()
    func didFavoriteButtonPressed()
    func didAddToListButtonPressed()
}

class MovieToWatchCollectionViewCell: UICollectionViewCell {
    //MARK: - property
    static let identifier: String = "MovieToWatchCollectionViewCell"
    weak var actionButtons: MovieToWatchCellDelegate?
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            updateWith(movie: movie)
        }
    }
    var poster: UIImage? {
        didSet {
            guard let poster = poster else { return }
            posterImage.image = poster
        }
    }
    private lazy var posterImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var dateLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var overviewLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var rateButton: UIButton = {
        return createButton(with: "star.circle", with: .white)
    }()
    private lazy var favoriteButton: UIButton = {
        return createButton(with: "heart.circle", with: .white)
    }()
    private lazy var addToListButton: UIButton = {
        return createButton(with: "list.bullet.circle", with: .white)
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error from MovieToWatchCollectionViewCell")
    }
    func updateWith(movie: Movie) {
        self.titleLabel.text = movie.title ?? "no title"
        self.dateLabel.text = movie.releaseDate ?? "no date"
        self.overviewLabel.text = movie.overview ?? "no overview"
    }
}
//MARK: - setupLayout
private extension MovieToWatchCollectionViewCell {
    func setupLayout() {
        setupImageView()
        setupTitleLabel()
        setupDateLabel()
        setupOverviewLabel()
        setupButtons()
    }
    func setupImageView() {
        self.contentView.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: self.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            posterImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3),
        ])
    }
    func setupTitleLabel() {
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.clipsToBounds = true
        titleLabel.minimumScaleFactor = 0.7
        titleLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            titleLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05)
        ])
    }
    func setupDateLabel() {
        self.contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .systemFont(ofSize: 15)
        dateLabel.textColor = .lightGray
        dateLabel.clipsToBounds = true
        dateLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 20),
            dateLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4)
        ])
    }
    func setupOverviewLabel() {
        self.contentView.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.font = .systemFont(ofSize: 15)
        overviewLabel.textColor = .white
        overviewLabel.minimumScaleFactor = 0.7
        overviewLabel.numberOfLines = 3
        overviewLabel.clipsToBounds = true
        overviewLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 15),
            overviewLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            
        ])
    }
    func setupButtons() {
        self.contentView.addSubview(rateButton)
        rateButton.translatesAutoresizingMaskIntoConstraints = false
        rateButton.addTarget(self, action: #selector(rateButtonPressed), for: .touchUpInside)
        
        self.contentView.addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(favoritePressed), for: .touchUpInside)
        
        self.contentView.addSubview(addToListButton)
        addToListButton.translatesAutoresizingMaskIntoConstraints = false
        addToListButton.addTarget(self, action: #selector(adddToListPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rateButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 15),
            rateButton.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 15),
            rateButton.widthAnchor.constraint(equalToConstant: 40),
            rateButton.heightAnchor.constraint(equalToConstant: 40),
            
            favoriteButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 15),
            favoriteButton.leadingAnchor.constraint(equalTo: rateButton.trailingAnchor, constant: 10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            addToListButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 15),
            addToListButton.leadingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 10),
            addToListButton.widthAnchor.constraint(equalToConstant: 40),
            addToListButton.heightAnchor.constraint(equalToConstant: 40),
            ])
    }
}
private extension MovieToWatchCollectionViewCell {
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
extension MovieToWatchCollectionViewCell {
    @objc func rateButtonPressed(selector: Selector) {
        actionButtons?.didRateButtonPressed()
    }
    @objc func favoritePressed(selector: Selector) {
        actionButtons?.didFavoriteButtonPressed()
    }
    @objc func adddToListPressed(selector: Selector) {
        actionButtons?.didAddToListButtonPressed()
    }
}
