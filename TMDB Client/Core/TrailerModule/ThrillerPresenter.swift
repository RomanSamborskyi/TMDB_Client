//
//  ThrillerPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit
import WebKit

protocol TrailerPresenterProtocol: AnyObject {
    func viewControllerDidLoaded()
    func showTrailer(in webView: WKWebView)
}

class TrailerPresenter {
    //MARK: - property
    weak var view: TrailerViewProtocol?
    let haptic: HapticFeedback
    let interactor: TrailerInteractorProtocol
    let router: TrailerRouterProtocol
    //MARK: - lifecycle
    init(haptic: HapticFeedback, interactor: TrailerInteractorProtocol, router: TrailerRouterProtocol) {
        self.haptic = haptic
        self.interactor = interactor
        self.router = router
    }
}
//MARK: - ThrillerPresenterProtocol
extension TrailerPresenter: TrailerPresenterProtocol {
    func showTrailer(in webView: WKWebView) {
        let url = URL(string: "https://youtube.com")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    func viewControllerDidLoaded() {
        Task {
            do {
                try await interactor.fetchTrailers()
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
