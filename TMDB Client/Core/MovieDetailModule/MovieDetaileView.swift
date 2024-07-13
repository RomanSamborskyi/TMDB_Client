//
//  MovieDetaileView.swift
//  UIKit practice
//
//  Created by Roman Samborskyi on 23.03.2024.
//

import UIKit


class MovieDetaileView: UIView {
   
    private lazy var backdropPoster: UIImageView = {
        let poster: UIImageView = UIImageView()
        return poster
    }()
    
    private lazy var mainPoster: UIImageView = {
        let poster: UIImageView = UIImageView()
        return poster
    }()
    
    private lazy var titleLable: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private lazy var overviewLabele: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private lazy var aboutMovieLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private lazy var runtimeLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        guard let button: UIButton = createButton(with: "bookmark") else {
            return UIButton()
        }
        return button
    }()
    
    private lazy var nextButtom: UIButton = {
        guard let button: UIButton = createButton(with: "arrow.right.circle") else {
            return UIButton()
        }
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        guard let button: UIButton = createButton(with: "square.and.arrow.up") else {
            return UIButton()
        }
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button: UIButton = UIButton()
        return button
    }()
    
    let action: (() -> Void)
    
    init(frame: CGRect, action: @escaping (() -> Void)) {
        self.action = action
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Fatal error!!!🆘")
    }
    
    func showDetaileView(for movie: Movie) {

    }
}

private extension MovieDetaileView {
    
    func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupBackdrop()
        setupPoster()
        setupTitleLable()
        setupReliseDateLabel()
        setupRuntimeLabel()
        setupGenreLabel()
        setupButtons()
        setupAboutMovieLabel()
        setupOverviewLabel()
        setupBackButton()
    }
    //MARK: - setup backdrop poster
    func setupBackdrop() {
        self.addSubview(backdropPoster)
        backdropPoster.translatesAutoresizingMaskIntoConstraints = false
        backdropPoster.image = UIImage(named: "backdrop")
        backdropPoster.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            backdropPoster.topAnchor.constraint(equalTo: self.topAnchor, constant: -20),
            backdropPoster.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            backdropPoster.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            backdropPoster.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    //MARK: - setup poster
    func setupPoster() {
        self.addSubview(mainPoster)
        mainPoster.translatesAutoresizingMaskIntoConstraints = false
        mainPoster.image = UIImage(named: "poster")
        mainPoster.layer.cornerRadius = 15
        mainPoster.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            mainPoster.topAnchor.constraint(equalTo: self.topAnchor, constant: 195),
            mainPoster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            mainPoster.widthAnchor.constraint(equalToConstant: 140),
            mainPoster.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    //MARK: - setup title label
    func setupTitleLable() {
        self.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        titleLable.text = "The Shawshank Redemption"
        titleLable.adjustsFontSizeToFitWidth = true
        titleLable.font = .systemFont(ofSize: 20, weight: .bold)
        titleLable.numberOfLines = 2
        titleLable.minimumScaleFactor = 0.7
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: backdropPoster.bottomAnchor, constant: 20),
            titleLable.leftAnchor.constraint(equalTo: mainPoster.rightAnchor, constant: 10),
            titleLable.widthAnchor.constraint(equalToConstant: 160),
           
        ])
    }
    //MARK: - setup relise date label
    func setupReliseDateLabel() {
        self.addSubview(releaseDateLabel)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        let image = setSystemImage(with: "calendar")
        self.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        releaseDateLabel.text = "1994-09-23"
        releaseDateLabel.font = .systemFont(ofSize: 15, weight: .regular)
        releaseDateLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 15),
            image.leftAnchor.constraint(equalTo: mainPoster.rightAnchor, constant: 10),
          
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 15),
            releaseDateLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            releaseDateLabel.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    //MARK: - setup runtime label
    func setupRuntimeLabel() {
        self.addSubview(runtimeLabel)
        runtimeLabel.translatesAutoresizingMaskIntoConstraints = false
        let image = setSystemImage(with: "clock")
        self.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        runtimeLabel.text = "118" + " " + "minutes"
        runtimeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        runtimeLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10),
            image.leftAnchor.constraint(equalTo: mainPoster.rightAnchor, constant: 10),
            
            runtimeLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10),
            runtimeLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            runtimeLabel.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    //MARK: - setup genre label
    func setupGenreLabel() {
        self.addSubview(genreLabel)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        let image = setSystemImage(with: "ticket")
        self.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        genreLabel.text = "Drama"
        genreLabel.font = .systemFont(ofSize: 15, weight: .regular)
        genreLabel.numberOfLines = 3
        genreLabel.textAlignment = .left
        genreLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 10),
            image.leftAnchor.constraint(equalTo: mainPoster.rightAnchor, constant: 10),
            
            genreLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 10),
            genreLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            genreLabel.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    //MARK: - setup all three buttons
    func setupButtons() {
        self.addSubview(saveButton)
        self.addSubview(nextButtom)
        self.addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: mainPoster.bottomAnchor, constant: 15),
            saveButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 60),
            saveButton.widthAnchor.constraint(equalToConstant: 60),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            
            nextButtom.topAnchor.constraint(equalTo: mainPoster.bottomAnchor, constant: 15),
            nextButtom.leftAnchor.constraint(equalTo: saveButton.rightAnchor, constant: 45),
            nextButtom.widthAnchor.constraint(equalToConstant: 60),
            nextButtom.heightAnchor.constraint(equalToConstant: 60),
            
            shareButton.topAnchor.constraint(equalTo: mainPoster.bottomAnchor, constant: 15),
            shareButton.leftAnchor.constraint(equalTo: nextButtom.rightAnchor, constant: 45),
            shareButton.widthAnchor.constraint(equalToConstant: 60),
            shareButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    //MARK: - setup About movie label
    func setupAboutMovieLabel() {
        self.addSubview(aboutMovieLabel)
        aboutMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        
        aboutMovieLabel.text = "About movie"
        aboutMovieLabel.font = .systemFont(ofSize: 25, weight: .bold)
        
        NSLayoutConstraint.activate([
            aboutMovieLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 15),
            aboutMovieLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
        ])
    }
    //MARK: - setup overview label
func setupOverviewLabel() {
        self.addSubview(overviewLabele)
        
        overviewLabele.translatesAutoresizingMaskIntoConstraints = false
        
        overviewLabele.text = "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope."
        overviewLabele.font = .systemFont(ofSize: 15, weight: .regular)
        overviewLabele.numberOfLines = .max
        
        NSLayoutConstraint.activate([
            overviewLabele.topAnchor.constraint(equalTo: aboutMovieLabel.bottomAnchor, constant: 15),
            overviewLabele.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            overviewLabele.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15)
        ])
    }
    //MARK: - setup backButton
    func setupBackButton() {
        self.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(nil, action: #selector(backButtonAction), for: .touchUpInside)
        
        if let originalImage = UIImage(systemName: "arrow.left.circle.fill") {
            let resizedImage = originalImage.resized(to: CGSize(width: 40, height: 40))?.withTintColor(.green)
                backButton.setImage(resizedImage, for: .normal)
            }
        
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
        ])
    }
}

private extension MovieDetaileView {
    ///Function that return specific system image with .customFontColor
    func setSystemImage(with name: String) -> UIImageView {
        let view: UIImageView = UIImageView(image: UIImage(systemName: name)!)
        view.tintColor = .green
        return view
    }
    /// Function to creat button in MovieDetailView. It return a button with specific image labele, with background and color .buttonColor and corner radius = 30
    func createButton(with label: String) -> UIButton? {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if let originalImage = UIImage(systemName: label) {
            let resizedImage = originalImage.resized(to: CGSize(width: 35, height: 35))?.withTintColor(.systemBackground)
                button.setImage(resizedImage, for: .normal)
            }
        
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .green
        button.layer.cornerRadius = 30
        return button
    }
    
    @objc func backButtonAction(selector: UIButton) {
        action()
    }
}

extension MovieDetaileView {
    //MARK: - update UI function
    
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
