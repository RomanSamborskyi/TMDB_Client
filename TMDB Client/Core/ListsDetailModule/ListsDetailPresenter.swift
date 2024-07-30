//
//  ListsDetailPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import UIKit


protocol ListsDetailPresenterProtocol: AnyObject {
    func didViewControllerLoad()
    func didListFetched(list: ListDetail, posters: [Int : UIImage])
    func didMovieSelected(movie: Movie, poster: UIImage)
}

class ListsDetailPresenter {
    //MARK: - property
    weak var view: ListsDetailViewProtocol?
    let interactor: ListsDetailInteractorProtocol?
    let router: ListsDetailRouterProtocol?
    //MARK: - lifecycle
    init(interactor: ListsDetailInteractorProtocol?, router: ListsDetailRouterProtocol?) {
        self.interactor = interactor
        self.router = router
    }
}
//MARK: - ListsDetailPresenterProtocol
extension ListsDetailPresenter: ListsDetailPresenterProtocol {
    func didMovieSelected(movie: Movie, poster: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.router?.navigateTo(movie: movie, poster: poster)
        }
    }
    func didListFetched(list: ListDetail, posters: [Int : UIImage]) {
        view?.showListDetail(list: list, posters: posters)
    }
    func didViewControllerLoad() {
        Task {
            do {
                try await interactor?.fetchDetails()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
}
