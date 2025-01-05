//
//  SearcPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import Foundation


protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class SearcPresenter {
    //MARK: - property
    weak var view: SearchViewControllerProtocol?
    let interactor: SearchInteractorProtocol
    let router: SearchRouterProtocol
    let haptic: HapticFeedback
    //MARK: - lifecyccle
    init(interactor: SearchInteractorProtocol, router: SearchRouterProtocol, haptic: HapticFeedback) {
        self.interactor = interactor
        self.router = router
        self.haptic = haptic
    }
}
//MARK: - SearchPresenterProtocol
extension SearcPresenter: SearchPresenterProtocol {
    func viewDidLoad() {
        Task {
            do {
                try await interactor.fetchSearchResult()
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
