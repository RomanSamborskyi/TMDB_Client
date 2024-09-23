//
//  MoviesCastView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 23.09.2024.
//

import UIKit

class MoviesCastView: UIView {
    //MARK: - property
    private lazy var photoView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var departmentLabel: UILabel = {
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
        self.departmentLabel.text = persone.character
    }
}
//MARK: - setup layout
private extension MoviesCastView {
    func setupLayout() {
        setupPhotoView()
        setupNameLabel()
        setupDepartmentLabel()
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
        ])
    }
    func setupDepartmentLabel() {
        self.addSubview(departmentLabel)
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        departmentLabel.font = .systemFont(ofSize: 8, weight: .semibold)
        departmentLabel.textColor = .gray.withAlphaComponent(0.6)
        departmentLabel.textAlignment = .center
        departmentLabel.minimumScaleFactor = 0.6
        departmentLabel.numberOfLines = 1
        departmentLabel.text = "department placeholder"
        
        NSLayoutConstraint.activate([
            departmentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            departmentLabel.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
        ])
    }
}
