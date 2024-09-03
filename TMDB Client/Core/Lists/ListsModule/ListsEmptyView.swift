//
//  ListsEmptyView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 13.08.2024.
//

import UIKit

class ListsEmptyView: UIView {
    //MARK: - property
    private lazy var textLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK: - UI setup
private extension ListsEmptyView {
    func setupLayout() {
       setupImage()
       setupLabel()
    }
    func setupImage() {
        self.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "list.bullet.clipboard.fill")
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
        textLabel.text = "The list is empty"
        textLabel.font = .systemFont(ofSize: 20, weight: .bold)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
