//
//  ActivityView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 11.07.2024.
//

import UIKit

class ActivityView: UIView {

    //MARK: - property
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black.withAlphaComponent(0.5)
        setupActivityView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Fatal error ActivityView")
    }
}
//MARK: - UI layout
private extension ActivityView {
    func setupActivityView() {
        self.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.style = .large
        activityView.startAnimating()
        
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

