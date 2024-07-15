//
//  MovieToWatchCollectionViewCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit

class MovieToWatchCollectionViewCell: UICollectionViewCell {
    //MARK: - property
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
        }
    }
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error from MovieToWatchCollectionViewCell")
    }
}
//MARK: - setupLayout
private extension MovieToWatchCollectionViewCell {
    
}
