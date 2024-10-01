//
//  ThrillerViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit
import WebKit

protocol TrailerViewProtocol: AnyObject {
   
}

class TrailerViewController: UIViewController, WKUIDelegate {
    //MARK: - property
    var presenter: TrailerPresenterProtocol?
    var webView: WKWebView!
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter?.showTrailer(in: webView)
    }
}
//MARK: - setup ui layout
private extension TrailerViewController {
    func setupLayout() {
        self.view.backgroundColor = .customBackground
        setupWebView()
        presenter?.viewControllerDidLoaded()
    }
    func setupWebView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        view = webView
    }
}
//MARK: - ThrillerViewProtocol
extension TrailerViewController: TrailerViewProtocol {
   
}
