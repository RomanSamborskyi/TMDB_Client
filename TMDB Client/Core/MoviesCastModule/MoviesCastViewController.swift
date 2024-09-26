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
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter?.viewControllerDidLoad()
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
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .customBackground
        
        setupActorDetailView()
    }
    func setupActorDetailView() {
        self.view.addSubview(actorDetailView)
        actorDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actorDetailView.topAnchor.constraint(equalTo: self.view.topAnchor),
            actorDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            actorDetailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            actorDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
