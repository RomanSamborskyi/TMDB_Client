//
//  SearchHistoryCollection.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 06.01.2025.
//

import UIKit

class SearchHistoryCollection: UICollectionViewCell {
    //MARK: - property
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error: SearchHistoryCollection")
    }
}
//MARK: - setup UI layout
private extension SearchHistoryCollection {
    func setupLayout() {
        
    }
}
