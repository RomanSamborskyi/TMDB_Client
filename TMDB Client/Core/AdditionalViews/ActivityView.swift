//
//  ActivityView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 11.07.2024.
//

import UIKit

class ActivityView: UIView {

    //MARK: - property
    let _backgroundColor: UIColor
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    //MARK: - lifecycle
    init(_backgroundColor: UIColor = .black.withAlphaComponent(0.5)) {
        self._backgroundColor = _backgroundColor
        super.init(frame: .zero)
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
        self.backgroundColor = _backgroundColor.withAlphaComponent(0.5)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.style = .large
        activityView.startAnimating()
        
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

