//
//  MoviesCastView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 23.09.2024.
//

import UIKit

class MoviesCastCaedView: UIView {
    //MARK: - property
    private lazy var photoView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func updatePhoto(with image: UIImage) {
        self.photoView.image = image
    }
    func updateView(with persone: Cast) {
        self.nameLabel.text = persone.name
    }
}
//MARK: - setup layout
private extension MoviesCastCaedView {
    func setupLayout() {
        setupPhotoView()
        setupNameLabel()
    }
    func setupPhotoView() {
        self.addSubview(photoView)
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.image = UIImage(named: "image")
        photoView.clipsToBounds = true
        photoView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            photoView.widthAnchor.constraint(equalToConstant: 60),
            photoView.heightAnchor.constraint(equalToConstant: 80),
            photoView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    func setupNameLabel() {
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.minimumScaleFactor = 0.6
        nameLabel.numberOfLines = 2
        nameLabel.text = "name placeholder"
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
}
