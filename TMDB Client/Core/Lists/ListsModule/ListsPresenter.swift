//
//  ListPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit
import NotificationCenter

protocol ListsPresenterProtocol: AnyObject {
    func viewControllerDidLoad()
    func didListsFetched(lists: [List])
    func didListsSelected(list: Int)
    func clearList(with id: Int)
    func deleteList(with id: Int)
    func didAddListButtonPressed()
    func viewWillAppear()
    var haptic: HapticFeedback { get }
}


class ListsPresenter {
    //MARK: - property
    weak var view: ListsViewControllerProtocol?
    let interactor: ListsInteratorProtocol
    let router: ListsRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecycle
    init(interactor: ListsInteratorProtocol, router: ListsRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - ListsPresenterProtocol
extension ListsPresenter: ListsPresenterProtocol {
    func viewWillAppear() {
        addObservers()
    }
    func didAddListButtonPressed() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.router.addList(networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, sessionId: self.interactor.sessionId, haptic: self.haptic)
        }
    }
    func deleteList(with id: Int) {
        Task {
            do {
                try await interactor.deleteList(with: id)
                view?.updateLayoutIfNeeded()
            } catch let error as AppError {
                print(error)
            }
        }
    }
    func clearList(with id: Int) {
        Task {
            do {
                try await interactor.clearList(with: id)
                view?.updateLayoutIfNeeded()
            } catch let error as AppError {
                print(error)
            }
        }
    }
    func didListsSelected(list: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.router.navigateToList(with: list, networkManager: self.interactor.networkManager, imageDownloader: self.interactor.imageDownloader, sessionId: self.interactor.sessionId, haptic: self.haptic)
        }
    }
    func viewControllerDidLoad() {
        Task {
            do {
                try await interactor.fetchLists()
            } catch let error as AppError {
                print(error)
            }
        }
    }
    func didListsFetched(lists: [List]) {
        view?.show(lists: lists)
    }
}
//MARK: - add observers
extension ListsPresenter {
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(observerAction), name: .listAdded, object: nil)
    }
    @objc func observerAction(notification: Notification) {
        Task {
            do {
                try await interactor.fetchLists()
                view?.updateLayoutIfNeeded()
            } catch let error as AppError {
                print(error)
            }
        }
    }
}
