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
        
        let gradient = getGradient()
        topCollectionPlaceholder.layer.insertSublayer(gradient, at: 0)
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        gradient.cornerRadius = 20
        gradient.animatedGradient()
        
        NSLayoutConstraint.activate([
            topCollectionPlaceholder.topAnchor.constraint(equalTo: self.topAnchor),
            topCollectionPlaceholder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            topCollectionPlaceholder.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 15),
            topCollectionPlaceholder.heightAnchor.constraint(equalToConstant: 60),
            topCollectionPlaceholder.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    func setupTopMoviesCollectionPalceholder() {
        self.addSubview(topMoviesCollectionPlaceholder)
        topMoviesCollectionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        let gradient = getGradient()
        topMoviesCollectionPlaceholder.layer.insertSublayer(gradient, at: 0)
        gradient.cornerRadius = 20
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 190)
        gradient.animatedGradient()
        
        NSLayoutConstraint.activate([
            topMoviesCollectionPlaceholder.topAnchor.constraint(equalTo: topCollectionPlaceholder.bottomAnchor, constant: 5),
            topMoviesCollectionPlaceholder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            topMoviesCollectionPlaceholder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15),
            topMoviesCollectionPlaceholder.heightAnchor.constraint(equalToConstant: 190),
            topMoviesCollectionPlaceholder.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        ])
    }
    func setupGenreCollectionPlaceholder() {
        self.addSubview(genreCollectionPlaceholder)
        genreCollectionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        let gradient = getGradient()
        genreCollectionPlaceholder.layer.insertSublayer(gradient, at: 0)
        gradient.cornerRadius = 20
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        gradient.animatedGradient()
        
        NSLayoutConstraint.activate([
            genreCollectionPlaceholder.topAnchor.constraint(equalTo: topMoviesCollectionPlaceholder.bottomAnchor, constant: 45),
            genreCollectionPlaceholder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            genreCollectionPlaceholder.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 15),
            genreCollectionPlaceholder.heightAnchor.constraint(equalToConstant: 60),
            genreCollectionPlaceholder.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    func setupBotttomMoviesCollectionPlaceholder() {
        self.addSubview(bottomMoviesCollectionPlaceholder)
        bottomMoviesCollectionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        let gradient = getGradient()
        bottomMoviesCollectionPlaceholder.layer.insertSublayer(gradient, at: 0)
        gradient.cornerRadius = 20
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 190)
        gradient.animatedGradient()
        
        NSLayoutConstraint.activate([
            bottomMoviesCollectionPlaceholder.topAnchor.constraint(equalTo: genreCollectionPlaceholder.bottomAnchor, constant: 5),
            bottomMoviesCollectionPlaceholder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            bottomMoviesCollectionPlaceholder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15),
            bottomMoviesCollectionPlaceholder.heightAnchor.constraint(equalToConstant: 190),
            bottomMoviesCollectionPlaceholder.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        ])
    }
}
//MARK: - gradient setup
private extension MoviesLoadingView {
    private func getGradient() -> CAGradientLayer {
        let grad = CAGradientLayer()
        grad.colors = [UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.black.withAlphaComponent(0.3).cgColor]
        grad.locations = [0.0, 0.5, 1.0]
        grad.startPoint = CGPoint(x: 0.0, y: 1.0)
        grad.endPoint = CGPoint(x: 1.0, y: 1.0)
        return grad
    }
}
