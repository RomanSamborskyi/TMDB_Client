//
//  MovieRateView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.08.2024.
//

import UIKit

//MARK: - Rate view delegate
protocol RateViewDelegate: AnyObject {
    
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
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: self.topAnchor),
            button1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            button2.topAnchor.constraint(equalTo: self.topAnchor),
            button2.leadingAnchor.constraint(equalTo: button1.leadingAnchor),
            
            button3.topAnchor.constraint(equalTo: self.topAnchor),
            button3.leadingAnchor.constraint(equalTo: button2.leadingAnchor),
            
            button4.topAnchor.constraint(equalTo: self.topAnchor),
            button4.leadingAnchor.constraint(equalTo: button3.leadingAnchor),
            
            button5.topAnchor.constraint(equalTo: self.topAnchor),
            button5.leadingAnchor.constraint(equalTo: button4.leadingAnchor),
        ])
    }
}
private extension MovieRateView {
    func makeButton() -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btn.imageView?.backgroundColor = UIColor.lightGray
        return btn
    }
}
