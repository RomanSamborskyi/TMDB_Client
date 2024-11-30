//
//  AddToListViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.08.2024.
//

import UIKit
import NotificationCenter

protocol AddToListViewProtocol: AnyObject {
    func showResults(movies: [Movie], posters: [Int : UIImage])
}

class AddToListViewController: UIViewController {
    //MARK: - property
    var presenter: AddToListPresenterProtocol?
    
    private lazy var textFieldView = TextFieldView()
    private lazy var searchResult: [Movie] = []
    private lazy var searchResultPosters: [Int : UIImage] = [:]
    private lazy var collectionCell: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.height / 3.7)
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
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.searchResult = movies
            self.searchResultPosters.merge(posters) { image, _ in image }
            self.collectionCell.reloadData()
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
        addKeyboardObserver()
    }
    func setupTextFieldView() {
        self.view.addSubview(textFieldView)
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.delegate = self
        
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
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AddToListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.searchResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListsResultCell.identifier, for: indexPath) as! ListsResultCell
        let item = self.searchResult[indexPath.row]
        cell.movie = item
        switch item.inList {
        case true:
            cell.buttonStyle = .inList
        case false:
            cell.buttonStyle = .add
        default:
            cell.buttonStyle = .add
        }
        cell.delegate = self
        cell.poster = self.searchResultPosters[item.id ?? 0]
        
        cell.clipsToBounds = true
        cell.backgroundColor = .black.withAlphaComponent(0.4)
        cell.layer.cornerRadius = 15
        return cell
    }
}
//MARK: - cell delegate
extension AddToListViewController: ListsResultCellDelegate {
    func didButtonTapped(for id: Int) {
        presenter?.didMovieAddedToList(with: id)
    }
}
//MARK: - Text field view delegate
extension AddToListViewController: TextFieldViewDelegate {
    func performSearch(text: String) {
        presenter?.didSearchStart(with: text)
    }
}
//MARK: - add observers to hide keyboard by tap
extension AddToListViewController {
    func addKeyboardObserver() {
        setupObserver()
    }
    func setupObserver() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(tapHandler))
        view.addGestureRecognizer(gesture)
    }
    @objc func tapHandler(_ notification: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
