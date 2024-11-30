//
//  ListsLoadingTableViewCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 30.11.2024.
//

import UIKit

class ListsLoadingTableViewCell: UITableViewCell {
    //MARK: - property
    static var identifier: String = "ListsLoadingTableViewCell"
    private lazy var itemView: UIView =  {
        let view = UIView()
        return view
    }()
    //MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK: - setup UI layout
private extension ListsLoadingTableViewCell {
    func setupLayout() {
        self.contentView.backgroundColor = .customBackground
        self.contentView.addSubview(itemView)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        let gradient = getGradient()
        
        itemView.layer.insertSublayer(gradient, at: 0)
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 5)
        gradient.animatedGradient()
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: self.topAnchor),
            itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
//MARK: - gradient setup
private extension ListsLoadingTableViewCell {
    private func getGradient() -> CAGradientLayer {
        let grad = CAGradientLayer()
        grad.colors = [UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.black.withAlphaComponent(0.3).cgColor]
        grad.locations = [0.0, 0.5, 1.0]
        grad.startPoint = CGPoint(x: 0.0, y: 1.0)
        grad.endPoint = CGPoint(x: 1.0, y: 1.0)
        return grad
    }
}
