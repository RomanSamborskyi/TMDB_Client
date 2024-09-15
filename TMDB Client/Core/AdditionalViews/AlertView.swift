//
//  AlertView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.09.2024.
//

import UIKit

class AlertView: UIView {
    //MARK: - property
    let title: String
    let imageName: String
    private lazy var titleLable: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    //MARK: - lifecycle
    init(titel: String, imageName: String) {
        self.imageName = imageName
        self.title = titel
        super.init(frame: .zero)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - setup layout
private extension AlertView {
    func setupLayout() {
        self.backgroundColor = .black.withAlphaComponent(0.7)
        setupImageView()
        setupLabel()
    }
    func setupImageView() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: self.imageName)
        imageView.tintColor = .white
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    func setupLabel() {
        self.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.text = self.title
        titleLable.font = .systemFont(ofSize: 25, weight: .bold)
        titleLable.textColor = .white
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLable.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }
}
