//
//  TopCollectionViewCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 13.07.2024.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {

    //MARK: - property
    static let identifire: String = "TopCollectionViewCell"
    private lazy var movieView = MovieCardView()
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            movieView.updateMovieCard(with: movie)
        }
    }
    var poster: UIImage? {
        didSet {
            guard let image = poster else { return }
            movieView.updatePoster(with: image)
        }
    }
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK: - setup
private extension TopCollectionViewCell {
    func setupLayout() {
        self.contentView.addSubview(movieView)
        movieView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            movieView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            movieView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            movieView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
