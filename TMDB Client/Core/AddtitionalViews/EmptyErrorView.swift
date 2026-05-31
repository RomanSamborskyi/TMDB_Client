//
//  EmptyView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 31.05.2026.
//

import UIKit

class EmptyErrorView: UIView {
    //MARK: - properties
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var labelView: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    var imageName: String = ""
    var textLable: String = "" {
        didSet {
            setupLayout()
            self.layoutIfNeeded()
        }
    }
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - setup layout
private extension EmptyErrorView {
    func setupLayout() {
        self.backgroundColor = .customBackground
        setupImageView()
        setupLabelView()
    }
    func setupImageView() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = UIColor.gray
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -80),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    func setupLabelView() {
        self.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.text = textLable
        labelView.font = .systemFont(ofSize: 20, weight: .bold)
        labelView.textColor = .gray
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10),
            labelView.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor)
        ])
    }
}
