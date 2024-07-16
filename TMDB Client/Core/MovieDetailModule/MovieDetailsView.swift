//
//  MovieDetailsView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit

class MovieDetailsView: UIView {

    //MARK: - property
    private lazy var posterView: UIImageView = {
        let view = UIImageView()
        return view
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
    }
}
//MARK: - UI layout
private extension MovieDetailsView {
    func setupLayout() {
        setupPosterView()
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
}
