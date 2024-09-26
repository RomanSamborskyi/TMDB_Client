//
//  MoviesCastViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastViewProtocol: AnyObject {
    func showActorInfo(actor: Cast, poster: UIImage)
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
        
        NSLayoutConstraint.activate([
            actorDetailView.topAnchor.constraint(equalTo: scroll.topAnchor),
            actorDetailView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            actorDetailView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            actorDetailView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            actorDetailView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -50),
        ])
    }
}
