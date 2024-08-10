//
//  ListsCollectionViewCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import UIKit

class ListsCollectionViewCell: UICollectionViewCell {
    //MARK: - property
    static let identifier: String = "ListsCollectionViewCell"
    var list: List? {
        didSet {
            guard let list = list else { return }
            self.updateCell(with: list)
        }
    }
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var itemCountLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func updateCell(with list: List) {
        self.titleLabel.text = list.name ?? ""
        self.descriptionLabel.text = list.description ?? ""
        self.itemCountLabel.text = "Items in list: \(list.itemCount ?? 0)"
    }
}
//MARK: - setup layout
private extension ListsCollectionViewCell {
    func setupLayout() {
        self.contentView.backgroundColor = .black.withAlphaComponent(0.4)
        setupTitleLabel()
        setupDescriptionLabel()
        setupItemsCountLabel()
    }
    func setupTitleLabel() {
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.white
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
    func setupDescriptionLabel() {
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.gray
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
    func setupItemsCountLabel() {
        self.contentView.addSubview(itemCountLabel)
        itemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        itemCountLabel.font = .systemFont(ofSize: 15, weight: .regular)
        itemCountLabel.numberOfLines = 0
        itemCountLabel.textAlignment = .left
        itemCountLabel.textColor = UIColor.gray
        
        NSLayoutConstraint.activate([
            itemCountLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20),
            itemCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
}
