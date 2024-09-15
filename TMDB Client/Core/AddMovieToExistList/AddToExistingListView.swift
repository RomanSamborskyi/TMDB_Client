//
//  AddToExistingListView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.09.2024.
//

import UIKit

class AddToExistingListView: UIView {
    //MARK: - property
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var additionalLabel: UILabel = {
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
}
//MARK: - setuplayout
private extension AddToExistingListView {
    func setupLayout() {
        setupLabel()
        setupAditionalLabel()
    }
    func setupLabel() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Add movie to existing list"
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    func setupAditionalLabel() {
        self.addSubview(additionalLabel)
        additionalLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalLabel.text = "To add movie to existing list, choose the one and tap on it"
        additionalLabel.font = .systemFont(ofSize: 15, weight: .regular)
        additionalLabel.textColor = .gray
        additionalLabel.textAlignment = .center
        additionalLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            additionalLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            additionalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            additionalLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
}
