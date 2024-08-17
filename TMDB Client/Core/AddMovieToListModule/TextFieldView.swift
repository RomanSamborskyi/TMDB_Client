//
//  TextFieldView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 17.08.2024.
//

import UIKit

class TextFieldView: UIView {
    //MARK: - property
    var searchResult: String = ""
    private lazy var textLabel: UILabel = {
        let txt = UILabel()
        return txt
    }()
    private lazy var searchFiled: UITextField = {
        let txt = UITextField()
        return txt
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
private extension TextFieldView {
    func setupLayout() {
        setupLabel()
        setupTextField()
    }
    func setupLabel() {
        self.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Add movie to list"
        textLabel.font = .systemFont(ofSize: 30, weight: .bold)
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: UIScreen.main.bounds.height * 0.08),
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    func setupTextField() {
        self.addSubview(searchFiled)
        searchFiled.translatesAutoresizingMaskIntoConstraints = false
        searchFiled.clipsToBounds = true
        searchFiled.layer.cornerRadius = 20
        searchFiled.borderStyle = .roundedRect
        searchFiled.textAlignment = .left
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.height))
        searchFiled.leftView = padding
        searchFiled.leftViewMode = .always
        searchFiled.rightView = padding
        searchFiled.rightViewMode = .always
        searchFiled.backgroundColor = .white
        searchFiled.textColor = .black
        self.searchResult = searchFiled.text ?? "no result"
        
        NSLayoutConstraint.activate([
            searchFiled.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.05),
            searchFiled.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            searchFiled.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            searchFiled.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
        ])
    }
}
