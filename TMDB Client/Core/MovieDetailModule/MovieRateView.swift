//
//  MovieRateView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.08.2024.
//

import UIKit

//MARK: - Rate view delegate
protocol RateViewDelegate: AnyObject {
    
}

class MovieRateView: UIView {
    //MARK: - property
    weak var delegate: RateViewDelegate?
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK: - ui layout
private extension MovieRateView {
    func setupLayout() {
        
    }
}
