//
//  SearchView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import UIKit

//MARK: - SearchTextfieldDelete
protocol SearchTextFieldDelegate: AnyObject {
    func search(text: String)
}

class SearchView: UIView {
    //MARK: - property
    weak var textFieldDelegate: SearchTextFieldDelegate?
    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error")
    }
}
//MARK: - setup UI layout
private extension SearchView {
    func setupLayout() {
        self.backgroundColor = .customBackground
        
        setupTextFiledView()
    }
    func setupTextFiledView() {
        self.addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.borderStyle = .roundedRect
        inputTextField.layer.cornerRadius = 20
        inputTextField.clipsToBounds = true
        inputTextField.backgroundColor = .white
        inputTextField.textColor = .black
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.height))
        inputTextField.leftView = padding
        inputTextField.leftViewMode = .always
        inputTextField.rightView = padding
        inputTextField.rightViewMode = .always
        
        let attributes: [NSAttributedString.Key: Any] = [
                  .foregroundColor: UIColor.lightGray,
                  .font: UIFont.systemFont(ofSize: 16)
              ]
        inputTextField.attributedPlaceholder = NSAttributedString(string: "Type to search", attributes: attributes)
        inputTextField.addTarget(self, action: #selector(performSearch), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            inputTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            inputTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            inputTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            inputTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05)
        ])
    }
}
//MARK: - text field extension
extension SearchView {
    @objc func performSearch(textFiled: UITextField) {
        if let result = textFiled.text {
            textFieldDelegate?.search(text: result)
        }
    }
}
