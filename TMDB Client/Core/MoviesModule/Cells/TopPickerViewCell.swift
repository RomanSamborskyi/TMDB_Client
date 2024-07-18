//
//  TopPickerViewCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 13.07.2024.
//

import UIKit

class TopPickerViewCell: UICollectionViewCell {
    //MARK: - property
    static let identifire: String = "TopPickerViewCell"
    var tab: TopTabs? {
        didSet {
            guard let tab = tab else { return }
            self.label.text = tab.description
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
        super.init(coder: coder)
    }
    
    private func setupLabel() {
        self.contentView.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.textColor = .gray
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
