//
//  EmptyView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 31.05.2026.
//

import UIKit

class EmptyErrorView: UIView {
    //MARK: - properties
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var labelView: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    public var imageName: String = ""
    var textLable: String = ""
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - setup layout
private extension EmptyErrorView {
    func setupLayout() {
        self.backgroundColor = .customBackground
        setupImageView()
    }
    func setupImageView() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "wifi.slash")
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
