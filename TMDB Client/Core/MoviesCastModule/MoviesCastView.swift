//
//  MoviesCastView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 26.09.2024.
//

import UIKit

protocol MoviesCastViewDelegate: AnyObject {
    func didBackButtonPresed()
}

class MoviesCastView: UIView {
    //MARK: - property
    weak var delegate: MoviesCastViewDelegate?
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
    private lazy var backButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private lazy var filmographyLabel: UILabel = {
        let label = UILabel()
        return label
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
        setupNameLabel()
        setupDateOfBirthLabel()
        setupPlaceOfBirthLabel()
        setupBiographyLabel()
        setupBackButton()
        setupFilmographyLabel()
    }
    func setupBackButton() {
        self.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "chevron.backward")?.resized(to: CGSize(width: 15, height: 15))?.withTintColor(.white)
        backButton.setImage(image, for: .normal)
        backButton.tintColor = .white
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 15
        backButton.backgroundColor = .black.withAlphaComponent(0.5)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: UIScreen.main.bounds.height * 0.08),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05),
            backButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.08),
            backButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.035)
        ])
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
    func setupBiographyLabel() {
        self.addSubview(biographyLabel)
        biographyLabel.translatesAutoresizingMaskIntoConstraints = false
        biographyLabel.font = .systemFont(ofSize: 15, weight: .regular)
        biographyLabel.textColor = .white
        biographyLabel.textAlignment = .left
        biographyLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: placeOfBirth.bottomAnchor, constant: UIScreen.main.bounds.height * 0.06),
            biographyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            biographyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
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
    func setupNameLabel() {
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
    func setupDateOfBirthLabel() {
        self.addSubview(dateOfBirthLabel)
        dateOfBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthLabel.font = .systemFont(ofSize: 15, weight: .regular)
        dateOfBirthLabel.textColor = .white.withAlphaComponent(0.7)
        dateOfBirthLabel.textAlignment = .center
        dateOfBirthLabel.numberOfLines = 3
        dateOfBirthLabel.minimumScaleFactor = 0.6
        dateOfBirthLabel.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            dateOfBirthLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: UIScreen.main.bounds.height * 0.06),
            dateOfBirthLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    func setupPlaceOfBirthLabel() {
        self.addSubview(placeOfBirth)
        placeOfBirth.translatesAutoresizingMaskIntoConstraints = false
        placeOfBirth.font = .systemFont(ofSize: 15, weight: .regular)
        placeOfBirth.textColor = .white.withAlphaComponent(0.7)
        placeOfBirth.textAlignment = .center
        placeOfBirth.numberOfLines = 3
        placeOfBirth.minimumScaleFactor = 0.6
        placeOfBirth.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            placeOfBirth.topAnchor.constraint(equalTo: dateOfBirthLabel.topAnchor, constant: UIScreen.main.bounds.height * 0.04 ),
            placeOfBirth.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    func setupFilmographyLabel() {
        self.addSubview(filmographyLabel)
        filmographyLabel.translatesAutoresizingMaskIntoConstraints = false
        filmographyLabel.text = "Filmography"
        filmographyLabel.textColor = .white
        filmographyLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        NSLayoutConstraint.activate([
            filmographyLabel.topAnchor.constraint(equalTo: self.biographyLabel.bottomAnchor, constant: 30),
            filmographyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            filmographyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
//MARK: - button ation
private extension MoviesCastView {
    @objc func backButtonAction(selector: Selector) {
        self.delegate?.didBackButtonPresed()
    }
}
