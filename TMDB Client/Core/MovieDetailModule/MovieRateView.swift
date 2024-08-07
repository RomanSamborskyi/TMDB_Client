//
//  MovieRateView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.08.2024.
//

import UIKit

//MARK: - Rate view delegate
protocol RateViewDelegate: AnyObject {
    func firstStarPressed()
    func secondStarPressed()
    func thirdStarPressed()
    func fourthStarPressed()
    func fifthStarPressed()
}

class MovieRateView: UIView {
    //MARK: - property
    weak var delegate: RateViewDelegate?
    private lazy var button1: UIButton = makeButton()
    private lazy var button2: UIButton = makeButton()
    private lazy var button3: UIButton = makeButton()
    private lazy var button4: UIButton = makeButton()
    private lazy var button5: UIButton = makeButton()
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
//MARK: - ui layout
private extension MovieRateView {
    func setupLayout() {
        setupButtonsLayot()
    }
    func setupButtonsLayot() {
        self.addSubview(button1)
        self.addSubview(button2)
        self.addSubview(button3)
        self.addSubview(button4)
        self.addSubview(button5)
        
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        button4.translatesAutoresizingMaskIntoConstraints = false
        button5.translatesAutoresizingMaskIntoConstraints = false
        
        button1.addTarget(self, action: #selector(firstButtonPressed), for: .touchUpInside)
        button2.addTarget(self, action: #selector(secondButtonPressed), for: .touchUpInside)
        button3.addTarget(self, action: #selector(thirdButtonPressed), for: .touchUpInside)
        button4.addTarget(self, action: #selector(fourthButtonPressed), for: .touchUpInside)
        button5.addTarget(self, action: #selector(fifthButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: self.topAnchor),
            button1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            button2.topAnchor.constraint(equalTo: self.topAnchor),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 10),
            
            button3.topAnchor.constraint(equalTo: self.topAnchor),
            button3.leadingAnchor.constraint(equalTo: button2.trailingAnchor, constant: 10),
            
            button4.topAnchor.constraint(equalTo: self.topAnchor),
            button4.leadingAnchor.constraint(equalTo: button3.trailingAnchor, constant: 10),
            
            button5.topAnchor.constraint(equalTo: self.topAnchor),
            button5.leadingAnchor.constraint(equalTo: button4.trailingAnchor, constant: 10),
        ])
    }
}
private extension MovieRateView {
    func makeButton() -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btn.tintColor = UIColor.gray
        return btn
    }
}
extension MovieRateView {
    @objc func firstButtonPressed(selector: Selector) {
        self.delegate?.firstStarPressed()
    }
    @objc func secondButtonPressed(selector: Selector) {
        self.delegate?.secondStarPressed()
    }
    @objc func thirdButtonPressed(selector: Selector) {
        self.delegate?.thirdStarPressed()
    }
    @objc func fourthButtonPressed(selector: Selector) {
        self.delegate?.fourthStarPressed()
    }
    @objc func fifthButtonPressed(selector: Selector) {
        self.delegate?.fifthStarPressed()
    }
}
