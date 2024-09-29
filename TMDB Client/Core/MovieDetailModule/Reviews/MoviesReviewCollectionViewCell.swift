//
//  MoviesReviewCollectionViewCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit

class MoviesReviewCollectionViewCell: UICollectionViewCell {
    //MARK: - property
    static let identifier: String = "MoviesReviewCollectionViewCell"
    private lazy var reviewView = MoviesReviewView()
    var review: Review? {
        didSet {
            guard let review = review else { return }
            reviewView.updateView(with: review)
        }
    }
    var avatar: UIImage? {
        didSet {
            guard let avatar = avatar else { return }
            reviewView.updateAvatar(with: avatar)
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
//MARK: - setup ui layout
private extension MoviesReviewCollectionViewCell {
    func setupLayout() {
        setupDetailView()
    }
    func setupDetailView() {
        self.contentView.addSubview(reviewView)
        reviewView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reviewView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            reviewView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            reviewView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            reviewView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
