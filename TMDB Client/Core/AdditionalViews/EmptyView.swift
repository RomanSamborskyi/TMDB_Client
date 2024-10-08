//
//  ListsEmptyView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 13.08.2024.
//

import UIKit

class EmptyView: UIView {
    //MARK: - property
    let imageName: String
    let title: String
    private lazy var textLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    //MARK: - lifecycle
    init(imageName: String, title: String) {
        self.imageName = imageName
        self.title = title
        super.init(frame: .zero)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        self.imageName = ""
        self.title = ""
        super.init(coder: coder)
    }
}
//MARK: - UI setup
private extension EmptyView {
    func setupLayout() {
       setupImage()
       setupLabel()
    }
    func setupImage() {
        self.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: self.imageName)
        image.tintColor = .white
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100),
        ])
        
    }
    func setupLabel() {
        self.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = self.title
        textLabel.font = .systemFont(ofSize: 20, weight: .bold)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
