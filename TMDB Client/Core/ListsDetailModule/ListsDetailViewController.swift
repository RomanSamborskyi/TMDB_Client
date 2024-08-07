//
//  ListsDetailViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import UIKit

protocol ListsDetailViewProtocol: AnyObject {
    func showListDetail(list: ListDetail, posters: [Int : UIImage])
}

class ListsDetailViewController: UIViewController {

    //MARK: - property
    var presenter: ListsDetailPresenterProtocol?
    private lazy var posters: [Int : UIImage] = [:]
    private lazy var movies: [Movie] = []
    private lazy var collection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width / 3.17, height: 190)
        flow.minimumInteritemSpacing = 5
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.identifire)
        return cell
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.didViewControllerLoad()
        setupLayout()
    }
}
//MARK: - ListsViewProtocol
extension ListsDetailViewController: ListsDetailViewProtocol {
    func showListDetail(list: ListDetail, posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            self?.posters = posters
            self?.movies = list.items ?? []
            self?.navigationItem.title = list.name
            self?.collection.reloadData()
        }
    }
}
//MARK: - setup layout
private extension ListsDetailViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor.customBackground
        self.collection.delegate = self
        self.collection.dataSource = self
        setupCollectionView()
    }
    func setupCollectionView() {
        self.view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.customBackground
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: self.view.topAnchor),
            collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
//MARK: - UICollectionDataSource & Delegate
extension ListsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifire, for: indexPath) as! TopCollectionViewCell
        let item = self.movies[indexPath.row]
        cell.movie = item
        cell.poster = self.posters[item.id ?? 0]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.movies[indexPath.row]
        guard let itemPoster = self.posters[item.id ?? 0] else {
            return
        }
        presenter?.didMovieSelected(movie: item, poster: itemPoster)
    }
}
