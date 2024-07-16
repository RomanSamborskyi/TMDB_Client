//
//  MainView.swift
//  UIKit practice
//
//  Created by Roman Samborskyi on 17.03.2024.
//

import UIKit

class MovieCardView: UIView {
    
   private lazy var rateLabel: UILabel = {
       let label: UILabel = UILabel()
       return label
    }()
    
    private lazy var posterImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateMovieCard(with movie: Movie) {
        rateLabel.text = movie.voteAverage?.twoCharacktersStrings
    }
    func updatePoster(with image: UIImage) {
        posterImage.image = image
    }
}

private extension MovieCardView {
    //MARK: - setup function
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupPosterImaggeView()
        setupRateLabel()

    }
    //MARK: - setup poster image view
    func setupPosterImaggeView() {
        self.addSubview(posterImage)
        self.posterImage.translatesAutoresizingMaskIntoConstraints = false
        self.posterImage.layer.cornerRadius = 15
        self.posterImage.clipsToBounds = true
        
       
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            posterImage.widthAnchor.constraint(equalToConstant: 115),
            posterImage.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    //MARK: - setup rate label
    func setupRateLabel() {
        self.addSubview(rateLabel)
        self.rateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.rateLabel.font = .systemFont(ofSize: 15, weight: .medium)
        self.rateLabel.textAlignment = .center
        self.rateLabel.adjustsFontSizeToFitWidth = true
        self.rateLabel.backgroundColor = UIColor.red
        self.rateLabel.textColor = .white
        self.rateLabel.layer.cornerRadius = 10
        self.rateLabel.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(equalTo: posterImage.topAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor),
            
            rateLabel.widthAnchor.constraint(equalToConstant: 35),
            rateLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}

