//
//  MoviesReviewView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit

class MoviesReviewView: UIView {
    //MARK: - property
    private lazy var avatarView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var reviewBy: UILabel = {
        let view = UILabel()
        return view
    }()
    private lazy var ratingByAuthor: UILabel = {
        let view = UILabel()
        return view
    }()
    private lazy var writenByAuthor: UILabel = {
        let view = UILabel()
        return view
    }()
    private lazy var reviewLabel: UILabel = {
        let view = UILabel()
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
    func updateView(with review: Review) {
        self.reviewBy.text = "A review by \(review.author)"
        self.ratingByAuthor.text = "\(review.authorDetails.rating ?? 0)"
        self.writenByAuthor.text = "Written by \(review.authorDetails.username) on \(review.createdAt.formatDateFromISO)"
        self.reviewLabel.text = review.content
    }
    func updateAvatar(with image: UIImage) {
        self.avatarView.image = image
    }
}
//MARK: - ui layout
private extension MoviesReviewView {
    func setupLayout() {
        setupAvatarView()
        setupReviewByLabel()
       // setupRatingyAuthorLabel()
        setupWritenByLabel()
        setupReviewLabel()
    }
    func setupAvatarView() {
        self.addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 15
        avatarView.image = UIImage(named: "image")
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            avatarView.widthAnchor.constraint(equalToConstant: 60),
            avatarView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    func setupReviewByLabel() {
        self.addSubview(reviewBy)
        reviewBy.translatesAutoresizingMaskIntoConstraints = false
        reviewBy.font = .systemFont(ofSize: 20, weight: .bold)
        reviewBy.textColor = .white
        
        NSLayoutConstraint.activate([
            reviewBy.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            reviewBy.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10),
            reviewBy.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    func setupRatingyAuthorLabel() {
        self.addSubview(ratingByAuthor)
        ratingByAuthor.translatesAutoresizingMaskIntoConstraints = false
        ratingByAuthor.font = .systemFont(ofSize: 15)
        ratingByAuthor.textColor = .white
        ratingByAuthor.backgroundColor = .gray
        ratingByAuthor.layer.cornerRadius = 15
        ratingByAuthor.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            ratingByAuthor.topAnchor.constraint(equalTo: reviewBy.bottomAnchor, constant: 10),
            ratingByAuthor.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10),
        ])
    }
    func setupWritenByLabel() {
        self.addSubview(writenByAuthor)
        writenByAuthor.translatesAutoresizingMaskIntoConstraints = false
        writenByAuthor.font = .systemFont(ofSize: 10)
        writenByAuthor.textColor = .white
        
        NSLayoutConstraint.activate([
            writenByAuthor.topAnchor.constraint(equalTo: reviewBy.bottomAnchor, constant: 5),
            writenByAuthor.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10),
            writenByAuthor.heightAnchor.constraint(equalToConstant: 20),
            writenByAuthor.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    func setupReviewLabel() {
        self.addSubview(reviewLabel)
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewLabel.font = .systemFont(ofSize: 15)
        reviewLabel.textColor = .white
        reviewLabel.textAlignment = .left
        reviewLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            reviewLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 10),
            reviewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            reviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            reviewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}
