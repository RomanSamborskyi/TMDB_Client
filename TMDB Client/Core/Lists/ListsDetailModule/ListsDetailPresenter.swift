//
//  ListsDetailPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import UIKit
import NotificationCenter

protocol ListsDetailPresenterProtocol: AnyObject {
    func didViewControllerLoad()
    func didListFetched(list: ListDetail, posters: [Int : UIImage])
    func didMovieSelected(movie: Movie, poster: UIImage)
    func didAddMovieToList(movies: [Movie])
    func deleteMovieFromList(with id: Int)
    func viewControllerWillAppear()
    var haptic: HapticFeedback { get }
}

class ListsDetailPresenter {
    //MARK: - property
    weak var view: ListsDetailViewProtocol?
    let interactor: ListsDetailInteractorProtocol
    let router: ListsDetailRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecycle
    init(interactor: ListsDetailInteractorProtocol, router: ListsDetailRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
//MARK: - ListsDetailPresenterProtocol
extension ListsDetailPresenter: ListsDetailPresenterProtocol {
    func viewControllerWillAppear() {
        addObserver()
    }
    func deleteMovieFromList(with id: Int) {
        Task {
            do {
                try await interactor.deleteMovie(with: id)
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
    func didAddMovieToList(movies: [Movie]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.router.addMovieToList(networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, listId: self.interactor.listId, sessionId: self.interactor.sessionId, haptic: self.haptic, movies: movies)
        }
    }
    func didMovieSelected(movie: Movie, poster: UIImage) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.router.navigateTo(movie: movie, poster: poster, networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, haptic: haptic, sessionId: self.interactor.sessionId, keychain: self.interactor.keychain)
        }
    }
    func didListFetched(list: ListDetail, posters: [Int : UIImage]) {
        view?.showListDetail(list: list, posters: posters)
    }
    func didViewControllerLoad() {
        Task {
            do {
                try await interactor.fetchDetails()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: - movies observer
extension ListsDetailPresenter {
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(observMoviesList), name: .movieAddedToList, object: nil)
    }
    @objc func observMoviesList(notificatio: Notification) {
        Task {
            do {
                try await interactor.fetchDetails()
            } catch let error as AppError {
                print(error.localizedDescription)
            }
        }
    }
}
