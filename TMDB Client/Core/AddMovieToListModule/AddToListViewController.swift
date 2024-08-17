//
//  AddToListViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.08.2024.
//

import UIKit

protocol AddToListViewProtocol: AnyObject {
    func showResults(movies: [Movie], posters: [Int : UIImage])
}

class AddToListViewController: UIViewController {
    //MARK: - property
    var persenter: AddToListPresenterProtocol?
    private lazy var textFieldView = TextFieldView()
    private lazy var searchResult: [Movie] = []
    private lazy var searchResultPosters: [Int : UIImage] = [:]
    private lazy var collectionCell: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.height * 0.2)
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(ListsResultCell.self, forCellWithReuseIdentifier: ListsResultCell.identifier)
        return cell
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}
//MARK: - AddToListViewProtocol
extension AddToListViewController: AddToListViewProtocol {
    func showResults(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async {
            self.searchResult.append(contentsOf: movies)
            self.searchResultPosters.merge(posters) { image, _ in image }
        }
    }
}
//MARK: - setup layout
private extension AddToListViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor.customBackground
        collectionCell.dataSource = self
        collectionCell.delegate = self
        
        setupTextFieldView()
        setupCollectionView()
    }
    func setupTextFieldView() {
        self.view.addSubview(textFieldView)
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: self.view.topAnchor),
            textFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    func setupCollectionView() {
        self.view.addSubview(collectionCell)
        collectionCell.translatesAutoresizingMaskIntoConstraints = false
        collectionCell.backgroundColor = UIColor.customBackground
        
        NSLayoutConstraint.activate([
            collectionCell.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 10),
            collectionCell.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionCell.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionCell.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
extension AddToListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListsResultCell.identifier, for: indexPath) as! ListsResultCell
       // let item = self.searchResult[indexPath.row]
        cell.movie = DeveloperPreview.instance.movie
        cell.buttonStyle = .add
        cell.poster = UIImage(named: "image")
        
        cell.clipsToBounds = true
        cell.backgroundColor = .black.withAlphaComponent(0.4)
        cell.layer.cornerRadius = 15
        return cell
    }
}
