//
//  MoviesCastView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 26.09.2024.
//

import UIKit

class MoviesCastView: UIView {
    //MARK: - property
    private lazy var posterView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var dateOfBirthLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var placeOfBirth: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var gradientView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var rateButtonsView = MovieRateView()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func updateView(with person: Cast, poster: UIImage) {
        self.nameLabel.text = person.name
        self.biographyLabel.text = person.biography
        self.dateOfBirthLabel.text = person.birthday
        self.placeOfBirth.text = person.placeOfBirth
        self.posterView.image = poster
    }
}
//MARK: - UI layout
private extension MoviesCastView {
    func setupLayout() {
        setupPosterView()
        setupGradientView()
        setupTitleLabel()
        setupOverviewLabel()
        
    }
    func setupGradientView() {
        self.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let colors = [UIColor.clear.cgColor, UIColor.customBackground.cgColor, UIColor.customBackground.cgColor]
        
        let gradient = CAGradientLayer()
        
        gradient.colors = colors
        gradient.locations = [0.0, 0.5, 1.0]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
        
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: self.topAnchor, constant: UIScreen.main.bounds.height / 3.7),
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2)
        ])
    }
    func setupOverviewLabel() {
        self.addSubview(biographyLabel)
        biographyLabel.translatesAutoresizingMaskIntoConstraints = false
        biographyLabel.font = .systemFont(ofSize: 15, weight: .regular)
        biographyLabel.textColor = .white
        biographyLabel.textAlignment = .left
        biographyLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            biographyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            biographyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
   
    func setupPosterView() {
        self.addSubview(posterView)
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.layer.cornerRadius = 25
        posterView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: self.topAnchor),
            posterView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            posterView.widthAnchor.constraint(equalTo: self.widthAnchor),
            posterView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1.4),
            
        ])
    }
    func setupTitleLabel() {
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 25, weight: .bold)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 3
        nameLabel.minimumScaleFactor = 0.6
        nameLabel.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: UIScreen.main.bounds.height / 3.8),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
