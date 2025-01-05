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
    private lazy var scroll: UIScrollView = {
        let scrlv = UIScrollView()
        return scrlv
    }()
    private lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: UIScreen.main.bounds.height / 3.7)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flow)
        view.register(ListsResultCell.self, forCellWithReuseIdentifier: ListsResultCell.identifier)
        return view
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        preseter?.viewDidLoad()
        setupLayout()
    }
}
//MARK: - SearchViewControllerProtocol
extension SearchViewController: SearchViewControllerProtocol {
    func showeResults(movies: [Movie], posters: [Int : UIImage]) {
        
    }
}
//MARK: - UI layout
private extension SearchViewController {
    func setupLayout() {
        self.view.backgroundColor = .customBackground
        self.navigationItem.title = "Movies search"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupScrollView()
        setupSearchView()
        setupCollectionView()
    }
    func setupSearchView() {
        self.scroll.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: self.scroll.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: self.scroll.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.scroll.trailingAnchor),
            searchView.widthAnchor.constraint(equalTo: self.scroll.widthAnchor),
           // searchView.bottomAnchor.constraint(equalTo: self.scroll.bottomAnchor)
        ])
    }
    func setupScrollView() {
        self.view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: self.view.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    func setupCollectionView() {
        self.scroll.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .customBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.searchView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.scroll.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.scroll.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.scroll.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.scroll.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.scroll.bottomAnchor),
        ])
    }
}
//MARK: - UICollectionDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListsResultCell.identifier, for: indexPath) as! ListsResultCell
        cell.backgroundColor = .blue
        return cell
    }
}
