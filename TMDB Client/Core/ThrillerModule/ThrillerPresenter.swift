//
//  ThrillerPresenter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit
import WebKit

protocol ThrillerPresenterProtocol: AnyObject {
    func viewControllerDidLoaded()
    func showThriller(in webView: WKWebView)
}

class ThrillerPresenter {
    //MARK: - property
    weak var view: ThrillerViewProtocol?
    let haptic: HapticFeedback
    let interactor: ThrillerInteractorProtocol
    let router: ThrillerRouterProtocol
    //MARK: - lifecycle
    init(haptic: HapticFeedback, interactor: ThrillerInteractorProtocol, router: ThrillerRouterProtocol) {
        self.haptic = haptic
        self.interactor = interactor
        self.router = router
    }
}
//MARK: - ThrillerPresenterProtocol
extension ThrillerPresenter: ThrillerPresenterProtocol {
    func showThriller(in webView: WKWebView) {
        let url = URL(string: "https://youtube.com")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    func viewControllerDidLoaded() {
        Task {
            do {
                try await interactor.fetchThriller()
            } catch let error as AppError {
                print(error.localized)
            }
        }
    }
}
