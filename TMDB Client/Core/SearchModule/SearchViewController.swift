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
    private lazy var searchState: SearchState = .ended
    private lazy var searchResults: [Movie] = []
    private lazy var posters: [Int : UIImage] = [:]
    private lazy var searchHistory: [String] = ["Pirates", "Transformers"]
    private lazy var movieCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.height / 3.7)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flow)
        return view
    }()
    private lazy var histroyCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.height * 0.05)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flow)
        return view
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        //TODO: - add clean up method here
        //TODO: - All this should be replaced and refacored
        self.searchState = .ended
        self.searchResults.removeAll()
        setupHistoryCollectionView()
        print(self.searchResults.count)
        print(self.searchState)
        print("Clean up logic should be here")
    }
}
//MARK: - SearchViewControllerProtocol
extension SearchViewController: SearchViewControllerProtocol {
    func showeResults(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            self?.searchResults = movies
            self?.posters.merge(posters) { image, _ in image }
            self?.movieCollection.reloadData()
        }
    }
}
//MARK: - UI layout
private extension SearchViewController {
    func setupLayout() {
        self.view.backgroundColor = .customBackground
        switch searchState {
        case .ended:
            setupHistoryCollectionView()
        case .started:
            setupMovieCollectionView()
        }
        addObservers()
    }
    func setupHistoryCollectionView() {
        self.view.addSubview(histroyCollection)
        histroyCollection.translatesAutoresizingMaskIntoConstraints = false
        histroyCollection.backgroundColor = .customBackground
        histroyCollection.delegate = self
        histroyCollection.dataSource = self
        histroyCollection.register(SearchHistoryCollection.self, forCellWithReuseIdentifier: SearchHistoryCollection.identifier)
        histroyCollection.register(SearchFieldCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchFieldCollectionReusableView.identifшer)
        
        NSLayoutConstraint.activate([
            histroyCollection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            histroyCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            histroyCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            histroyCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    func setupMovieCollectionView() {
        self.view.addSubview(movieCollection)
        movieCollection.translatesAutoresizingMaskIntoConstraints = false
        movieCollection.backgroundColor = .customBackground
        movieCollection.delegate = self
        movieCollection.dataSource = self
        movieCollection.register(ListsResultCell.self, forCellWithReuseIdentifier: ListsResultCell.identifier)
        movieCollection.register(SearchFieldCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchFieldCollectionReusableView.identifшer)
        
        NSLayoutConstraint.activate([
            movieCollection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            movieCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            movieCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            movieCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
//MARK: - UICollectionDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchHistoryCollection.identifier, for: indexPath) as! SearchHistoryCollection
            let item = self.searchHistory[indexPath.row]
            cell.updateLabel(with: item)
            return cell
        case .started:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListsResultCell.identifier, for: indexPath) as! ListsResultCell
            let item = self.searchResults[indexPath.row]
            cell.movie = item
            cell.poster = self.posters[item.id ?? 0]
            cell.clipsToBounds = true
            cell.backgroundColor = .black.withAlphaComponent(0.4)
            cell.layer.cornerRadius = 10
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchFieldCollectionReusableView.identifшer, for: indexPath) as! SearchFieldCollectionReusableView
        header.setupView()
        header.textFieldDelegate = self
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.08)
    }
}
//MARK: - SearchTextfieldDelete
extension SearchViewController: SearchTextFieldDelegate {
    func search(text: String) {
        preseter?.startSearch(text: text)
        
        if text.count > 3 {
            self.searchState = .started
            setupMovieCollectionView()
            self.movieCollection.reloadData()
        } else {
            self.searchState = .ended
            setupHistoryCollectionView()
            self.histroyCollection.reloadData()
        }
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
