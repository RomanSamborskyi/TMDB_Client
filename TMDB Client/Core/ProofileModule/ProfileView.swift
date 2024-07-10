//
//  WelcomeView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit

class ProfileView: UIView {
    //MARK: - property
    private lazy var avatarView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var usernameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var logoutButton: UIButton = {
        let lbl = UIButton()
        return lbl
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error from WelcomeView")
    }
    func updateView(with user: UserProfile, with avatar: UIImage) {
        avatarView.image = avatar
        nameLabel.text = user.name
        usernameLabel.text = user.username
    }
}
//MARK: - UI layout
private extension ProfileView {
    func setupLayout() {
        setupAvatarImage()
        setupNameLabel()
        setupUsernameLabel()
    }
    func setupAvatarImage() {
        self.addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.image = UIImage(named: "image")
        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 100
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: 200),
            avatarView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    func setupNameLabel() {
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "[NAME]"
        nameLabel.font = .systemFont(ofSize: 40, weight: .bold)
        nameLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    func setupUsernameLabel() {
        self.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "[USERNAME]"
        usernameLabel.font = .systemFont(ofSize: 25)
        usernameLabel.textColor = .lightGray
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
