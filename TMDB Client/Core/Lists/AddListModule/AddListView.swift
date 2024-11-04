//
//  AddListView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 23.08.2024.
//

import UIKit


protocol AddListViewDelegate: AnyObject {
    func didCreateButtonPressed(with title: String,_ description: String)
}

class AddListView: UIView {
    //MARK: - property
    weak var delegate: AddListViewDelegate?
    private let atributes: [NSAttributedString.Key : Any] = [.foregroundColor : UIColor.lightGray, .font : UIFont.systemFont(ofSize: 15, weight: .light)]
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var titleFiled: UITextField = {
        let txt = UITextField()
        return txt
    }()
    private lazy var descriptionFiled: UITextField = {
        let txt = UITextField()
        return txt
    }()
    private lazy var createButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK: - setup layout
private extension AddListView {
    func setupLayout() {
        setupTitleLabel()
        setupTextField()
        setupDescriptionField()
        setupLoginButton()
    }
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Add new list"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    func setupTextField() {
        self.addSubview(titleFiled)
        titleFiled.translatesAutoresizingMaskIntoConstraints = false
        titleFiled.clipsToBounds = true
        titleFiled.layer.cornerRadius = 20
        titleFiled.borderStyle = .roundedRect
        titleFiled.textAlignment = .left
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.height))
        titleFiled.leftView = padding
        titleFiled.leftViewMode = .always
        titleFiled.rightView = padding
        titleFiled.rightViewMode = .always
        titleFiled.backgroundColor = .white
        titleFiled.textColor = .black
        titleFiled.attributedPlaceholder = NSAttributedString(string: "List title", attributes: atributes)
        
        
        NSLayoutConstraint.activate([
            titleFiled.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05),
            titleFiled.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.height * 0.03),
            titleFiled.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIScreen.main.bounds.height * 0.03),
            titleFiled.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
        ])
    }
    func setupDescriptionField() {
        self.addSubview(descriptionFiled)
        descriptionFiled.translatesAutoresizingMaskIntoConstraints = false
        descriptionFiled.clipsToBounds = true
        descriptionFiled.layer.cornerRadius = 20
        descriptionFiled.borderStyle = .roundedRect
        descriptionFiled.textAlignment = .left
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.height))
        descriptionFiled.leftView = padding
        descriptionFiled.leftViewMode = .always
        descriptionFiled.rightView = padding
        descriptionFiled.rightViewMode = .always
        descriptionFiled.backgroundColor = .white
        descriptionFiled.textColor = .black
        descriptionFiled.attributedPlaceholder = NSAttributedString(string: "List description", attributes: atributes)
        
        NSLayoutConstraint.activate([
            descriptionFiled.topAnchor.constraint(equalTo: titleFiled.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05),
            descriptionFiled.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.height * 0.03),
            descriptionFiled.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIScreen.main.bounds.height * 0.03),
            descriptionFiled.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
        ])
    }
    func setupLoginButton() {
        self.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(UIColor.customBackground, for: .normal)
        createButton.backgroundColor = .white
        createButton.layer.cornerRadius = 20
        createButton.clipsToBounds = true
        createButton.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: descriptionFiled.bottomAnchor, constant: UIScreen.main.bounds.height * 0.09),
            createButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.height * 0.03),
            createButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIScreen.main.bounds.height * 0.03),
            createButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06),
        ])
    }
}
//MARK: - buuton action
extension AddListView {
    @objc func createButtonAction(selector: Selector) {
        guard let title = titleFiled.text,
              let description = descriptionFiled.text else {
            return
        }
        delegate?.didCreateButtonPressed(with: title, description)
    }
}
