//
//  ThrillerViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit
import WebKit

protocol TrailerViewProtocol: AnyObject {
    func showTrailer(with url: String)
}

class TrailerViewController: UIViewController {
    //MARK: - property
    var presenter: TrailerPresenterProtocol?
    private lazy var trailerCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(TrailerCollectionViewCell.self, forCellWithReuseIdentifier: TrailerCollectionViewCell.identifier)
        return cell
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewControllerDidLoaded()
        setupLayout()
    }
}
//MARK: - setup ui layout
private extension TrailerViewController {
    func setupLayout() {
        self.view.backgroundColor = .customBackground
        setupTrailerCollectionView()
    }
    func setupTrailerCollectionView() {
        self.view.addSubview(trailerCollection)
        trailerCollection.backgroundColor = .customBackground
        trailerCollection.translatesAutoresizingMaskIntoConstraints = false
        trailerCollection.delegate = self
        trailerCollection.dataSource = self
        
        NSLayoutConstraint.activate([
            trailerCollection.topAnchor.constraint(equalTo: self.view.topAnchor),
            trailerCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            trailerCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            trailerCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
//MARK: - ThrillerViewProtocol
extension TrailerViewController: TrailerViewProtocol {
    func showTrailer(with url: String) {
        DispatchQueue.main.async {
            
        }
    }
}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension TrailerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerCollectionViewCell.identifier, for: indexPath) as! TrailerCollectionViewCell
        cell.backgroundColor = .red
        
        return cell
    }
}
