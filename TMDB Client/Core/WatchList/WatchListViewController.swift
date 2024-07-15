//
//  WatchListViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchListViewProtocol: AnyObject {
    func show(movies: [Movie], posters: [Int : UIImage])
}

class WatchListViewController: UIViewController {

    //MARK: - property
    var presenter: WatchListPresenterProtocol?
    private lazy var movies: [Movie] = []
    private lazy var posters: [Int : UIImage] = [:]
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}
//MARK: - UI layout
private extension WatchListViewController {
    func setupLayout() {
        self.navigationItem.title = "Movies to watch"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor.customBackground
    }
}
//MARK: -
extension WatchListViewController: WatchListViewProtocol {
    func show(movies: [Movie], posters: [Int : UIImage]) {
        DispatchQueue.main.async { [weak self] in
            self?.movies.append(contentsOf: movies)
            self?.posters.merge(posters, uniquingKeysWith: { image, _ in image})
        }
    }
}
