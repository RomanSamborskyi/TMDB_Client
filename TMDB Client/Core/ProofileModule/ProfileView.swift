//
//  WelcomeView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit

class ProfileView: UIView {
    //MARK: - property
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error from WelcomeView")
    }
}
//MARK: - UI layout
private extension ProfileView {
    func setupLayout() {
        
    }
}
