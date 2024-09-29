//
//  MoviesCastViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastViewProtocol: AnyObject {
    func showActorInfo(actor: Cast, poster: UIImage)
    func showActorsFilmography(movies: [Movie], posters: [Int : UIImage])
}
 
class MoviesCastViewController: UIViewController {
    //MARK: - property
    var presenter: MoviesCastPresenterProtocol?
    private lazy var actorDetailView = MoviesCastView()
    private lazy var filmography: [Movie] = []
    private lazy var posters: [Int : UIImage] = [:]
    private lazy var scroll: UIScrollView = {
        let scrlv = UIScrollView()
        return scrlv
    }()
    private lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = .init(width: UIScreen.main.bounds.width / 3.17, height: 190)
        flow.scrollDirection = .horizontal
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.identifire)
        return cell
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter?.viewControllerDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
}
//MARK: - MoviesCastViewProtocol
extension MoviesCastViewController: MoviesCastViewProtocol {
    func showActorsFilmography(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.filmography.append(contentsOf: movies)
            self.posters.merge(posters) { image, _ in image }
            collectionView.reloadData()
        }
    }
    func showActorInfo(actor: Cast, poster: UIImage) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.actorDetailView.updateView(with: actor, poster: poster)
        }
    }
}
//MARK: - setup layout
private extension MoviesCastViewController {
    func setupLayout() {
        self.view.backgroundColor = .customBackground
        scroll.contentInsetAdjustmentBehavior = .never
        
        setupScrollView()
        setupActorDetailView()
        setupCollectionView()
    }
    func setupCollectionView() {
        self.scroll.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .customBackground
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: actorDetailView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.06),
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
    func setupActorDetailView() {
        self.scroll.addSubview(actorDetailView)
        actorDetailView.translatesAutoresizingMaskIntoConstraints = false
        actorDetailView.delegate = self
        
        NSLayoutConstraint.activate([
            actorDetailView.topAnchor.constraint(equalTo: scroll.topAnchor),
            actorDetailView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            actorDetailView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            actorDetailView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
        ])
    }
}
//MARK: - MoviesCastViewDelegate
extension MoviesCastViewController: MoviesCastViewDelegate {
    func didBackButtonPresed() {
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MoviesCastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.filmography.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifire, for: indexPath) as! TopCollectionViewCell
        let movie = self.filmography[indexPath.item]
        let poster = self.posters[movie.id ?? 0]
        
        cell.movie = movie
        cell.poster = poster
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.filmography[indexPath.row]
        let poster = self.posters[movie.id ?? 0]
    }
}
