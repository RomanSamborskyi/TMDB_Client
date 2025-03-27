//
//  SearchHistoryCollection.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 06.01.2025.
//

import UIKit

class SearchHistoryCollection: UICollectionViewCell {
    //MARK: - property
    static let identifier: String = "SearchHistoryCollection"
    private lazy var searchHistoryText: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error: SearchHistoryCollection")
    }
    func updateLabel(with text: String) {
        self.searchHistoryText.text = text
    }
}
//MARK: - setup UI layout
private extension SearchHistoryCollection {
    func setupLayout() {
        self.addSubview(searchHistoryText)
        searchHistoryText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchHistoryText.topAnchor.constraint(equalTo: self.topAnchor),
            searchHistoryText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchHistoryText.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchHistoryText.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
