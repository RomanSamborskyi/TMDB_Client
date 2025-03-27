//
//  CollectionReusableView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.01.2025.
//

import UIKit

//MARK: - SearchTextfieldDelete
protocol SearchTextFieldDelegate: AnyObject {
    func search(text: String)
}

class SearchFieldCollectionReusableView: UICollectionReusableView {
    //MARK: - properties
    weak var textFieldDelegate: SearchTextFieldDelegate?
    static let identifшer: String = "SearchFieldCollectionReusableView"
    private lazy var inputTextField: UITextField = {
        let field = UITextField()
        return field
    }()
    //MARK: - lifecycle
    public func setupView() {
        setupLayout()
    }
}
//MARK: - setup UI layout
private extension SearchFieldCollectionReusableView {
    func setupLayout() {
        setupTextField()
    }
    func setupTextField() {
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
        inputTextField.addTarget(self, action: #selector(performSearch), for: .editingDidEnd)
        
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: self.topAnchor),
            inputTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            inputTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            inputTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }
}
//MARK: - text field extension
extension SearchFieldCollectionReusableView {
    @objc func performSearch(textFiled: UITextField) {
        if let result = textFiled.text {
            textFieldDelegate?.search(text: result)
        }
    }
}
