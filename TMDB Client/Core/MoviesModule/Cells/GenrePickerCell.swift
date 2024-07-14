//
//  GenrePickerCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 13.07.2024.
//

import UIKit


class GenrePickerCell: UICollectionViewCell {
    //MARK: - property
    static let identifire: String = "GenrePickerCell"
    var tab: Genre? {
        didSet {
            guard let tab = tab else { return }
            self.label.text = tab.name
        }
    }
    lazy var label: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Fatal error TopPickerViewCell")
    }
    
    private func setupLabel() {
        self.contentView.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.textColor = .white
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

