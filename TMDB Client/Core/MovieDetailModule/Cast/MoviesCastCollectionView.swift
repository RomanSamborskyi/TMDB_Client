//
//  MoviesCastCollectionView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 23.09.2024.
//

import UIKit

class MoviesCastCollectionView: UICollectionViewCell {
    //MARK: - property
    static let identifier: String = "MoviesCastCollectionView"
    private lazy var castView = MoviesCastView()
    var photo: UIImage? {
        didSet {
            guard let photo = photo else { return }
            castView.updatePhoto(with: photo)
        }
    }
    var persone: Cast? {
        didSet {
            guard let persone = persone else { return }
            castView.updateView(with: persone)
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
//MARK: - setup layout
private extension MoviesCastCollectionView {
    func setupLayout() {
        self.contentView.addSubview(castView)
        castView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            castView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            castView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            castView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            castView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
