//
//  MoviesLoadingView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 24.11.2024.
//

import UIKit

class MoviesLoadingView: UIView {
    //MARK: - property
    private lazy var topCollectionPlaceholder: UIView = UIView()
    private lazy var topMoviesCollectionPlaceholder: UIView = UIView()
    private lazy var genreCollectionPlaceholder: UIView = UIView()
    private lazy var bottomMoviesCollectionPlaceholder: UIView = UIView()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK: - setup UI layout
private extension MoviesLoadingView {
    func setupLayout() {
        self.backgroundColor = .customBackground
        
        setupTopCollectionPlaceholder()
        setupTopMoviesCollectionPalceholder()
        setupGenreCollectionPlaceholder()
        setupBotttomMoviesCollectionPlaceholder()
        
    }
    func setupTopCollectionPlaceholder() {
        self.addSubview(topCollectionPlaceholder)
        topCollectionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        topCollectionPlaceholder.backgroundColor = .black.withAlphaComponent(0.3)
        topCollectionPlaceholder.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            topCollectionPlaceholder.topAnchor.constraint(equalTo: self.topAnchor),
            topCollectionPlaceholder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            topCollectionPlaceholder.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 15),
            topCollectionPlaceholder.heightAnchor.constraint(equalToConstant: 50),
            topCollectionPlaceholder.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    func setupTopMoviesCollectionPalceholder() {
        self.addSubview(topMoviesCollectionPlaceholder)
        topMoviesCollectionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        topMoviesCollectionPlaceholder.backgroundColor = .black.withAlphaComponent(0.3)
        topMoviesCollectionPlaceholder.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            topMoviesCollectionPlaceholder.topAnchor.constraint(equalTo: topCollectionPlaceholder.bottomAnchor, constant: 10),
            topMoviesCollectionPlaceholder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topMoviesCollectionPlaceholder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15),
            topMoviesCollectionPlaceholder.heightAnchor.constraint(equalToConstant: 190),
            topMoviesCollectionPlaceholder.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        ])
    }
    func setupGenreCollectionPlaceholder() {
        
    }
    func setupBotttomMoviesCollectionPlaceholder() {
        
    }
}
