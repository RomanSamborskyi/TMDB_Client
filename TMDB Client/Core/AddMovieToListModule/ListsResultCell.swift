//
//  ListsResultCell.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 17.08.2024.
//

import UIKit


protocol ListsResultCellDelegate: AnyObject {
    func didButtonTapped(for id: Int)
}

enum ButtonStyle {
    case add, delete
}

class ListsResultCell: UICollectionViewCell {
    //MARK: - property
    static let identifier: String = "ListsResultCell"
    weak var delegate: ListsResultCellDelegate?
    var buttonStyle: ButtonStyle? {
        didSet {
            switch buttonStyle {
            case .add:
                updateButtonStyle(with: "plus", color: .white)
            case .delete:
                updateButtonStyle(with: "trash", color: .red)
            case nil:
                break
            }
        }
    }
    var movie: Movie? {
        didSet {
            updateCell(with: movie)
        }
    }
    var poster: UIImage? {
        didSet {
            guard let poster = poster else { return }
            self.posterView.image = poster
        }
    }
    private lazy var posterView: UIImageView = {
        let poster = UIImageView()
        return poster
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var button: UIButton = {
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
    private func updateCell(with movie: Movie?) {
        guard let movie else { return }
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseDate
    }
    private func updateButtonStyle(with image: String, color: UIColor) {
        button.setImage(UIImage(systemName: image), for: .normal)
        button.tintColor = color
        button.layer.borderWidth = 2
        button.layer.borderColor = color.cgColor
        button.layer.cornerRadius = 15
    }
}
//MARK: - setup layout
private extension ListsResultCell {
    func setupLayout() {
        setupPosterView()
        setupTitleLabel()
        setupReliseLabel()
        setupButton()
    }
    func setupPosterView() {
        self.contentView.addSubview(posterView)
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.contentMode = .scaleToFill
        posterView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            posterView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            posterView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4)
        ])
    }
    func setupTitleLabel() {
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.clipsToBounds = true
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.posterView.trailingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
            
        ])
    }
    func setupReliseLabel() {
        self.contentView.addSubview(yearLabel)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.clipsToBounds = true
        yearLabel.textColor = .gray
        yearLabel.font = .systemFont(ofSize: 15, weight: .bold)
        yearLabel.numberOfLines = 0
        yearLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            yearLabel.leadingAnchor.constraint(equalTo: self.posterView.trailingAnchor, constant: 10),
            
        ])
    }
    func setupButton() {
        self.contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10),
            button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 35),
            button.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
}
//MARK: - button action
private extension ListsResultCell {
    @objc func buttonAction(selector: Selector) {
        self.delegate?.didButtonTapped(for: movie?.id ?? 0)
        if buttonStyle == .add {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.4) {
                    self.updateButtonStyle(with: "checkmark", color: .green)
                }
            }
        }
    }
}
