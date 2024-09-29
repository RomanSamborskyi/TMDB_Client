//
//  ReviewTextLabel.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit

class ReviewTextLabel: UIView {
    //MARK: - property
    let textLabel: String
    private lazy var reviewLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    //MARK: - lifecycle
    init(textLabel: String) {
        self.textLabel = textLabel
        super.init(frame: .zero)
        setupLabel()
    }
    required init?(coder: NSCoder) {
        self.textLabel = ""
        super.init(coder: coder)
    }
    
    func setupLabel() {
        self.addSubview(reviewLabel)
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewLabel.font = .systemFont(ofSize: 20, weight: .bold)
        reviewLabel.textColor = .white
        reviewLabel.text = textLabel
        
        NSLayoutConstraint.activate([
            reviewLabel.topAnchor.constraint(equalTo: self.topAnchor),
            reviewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            reviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            reviewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
