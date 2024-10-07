//
//  TrailerCollectionViewCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 06.10.2024.
//

import UIKit

class TrailerCollectionViewCell: UICollectionViewCell {
    //MARK: - property
    static let identifier: String = "TrailerCollectionViewCell"
    var trailerURL: String? {
        didSet {
            trailerView.showTrailer(with: trailerURL ?? "")
        }
    }
    private lazy var trailerView = TrailerView()
    //MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK: - ui layout
private extension TrailerCollectionViewCell {
    func setupLayout() {
        self.contentView.addSubview(trailerView)
        trailerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trailerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            trailerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            trailerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            trailerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
