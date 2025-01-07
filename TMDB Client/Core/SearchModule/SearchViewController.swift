//
//  SearchViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func showeResults(movies: [Movie], posters: [Int : UIImage])
}

class SearchViewController: UIViewController {
    //MARK: - property
    var preseter: SearchPresenterProtocol?
    private lazy var searchView = SearchView()
    private lazy var searchState: SearchState = .started
    private lazy var searchResults: [Movie] = []
    private lazy var posters: [Int : UIImage] = [:]
    private lazy var searchHistory: [String] = []
    private lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.height / 3.7)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flow)
        return view
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}
//MARK: - SearchViewControllerProtocol
extension SearchViewController: SearchViewControllerProtocol {
    func showeResults(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            self?.searchResults = movies
            self?.posters.merge(posters) { image, _ in image }
            self?.collectionView.reloadData()
        }
    }
}
//MARK: - UI layout
private extension SearchViewController {
    func setupLayout() {
        self.view.backgroundColor = .customBackground
        setupSearchView()
        setupCollectionView()
        addObservers()
    }
    func setupSearchView() {
        self.view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.textFieldDelegate = self
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .customBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ListsResultCell.self, forCellWithReuseIdentifier: ListsResultCell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.searchView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
//MARK: - UICollectionDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch searchState {
        case .ended:
            return self.searchHistory.count
        case .started:
            return self.searchResults.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch searchState {
        case .ended:
            return UICollectionViewCell()
        case .started:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListsResultCell.identifier, for: indexPath) as! ListsResultCell
            let item = self.searchResults[indexPath.row]
            cell.movie = item
            cell.poster = self.posters[item.id ?? 0]
            cell.clipsToBounds = true
            cell.backgroundColor = .black.withAlphaComponent(0.4)
            cell.layer.cornerRadius = 15
            return cell
        }
    }
}
//MARK: - SearchTextfieldDelete
extension SearchViewController: SearchTextFieldDelegate {
    func search(text: String) {
        preseter?.startSearch(text: text)
    }
}
//MARK: - keyboard observers
extension SearchViewController {
    func addObservers() {
        setupObservers()
    }
    func setupObservers() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(tapHandler))
        view.addGestureRecognizer(gesture)
    }
    @objc func tapHandler(_ notification: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
