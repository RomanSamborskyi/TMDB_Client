//
//  ThrillerViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.09.2024.
//

import UIKit
import WebKit

protocol ThrillerViewProtocol: AnyObject {
   
}

class ThrillerViewController: UIViewController, WKUIDelegate {
    //MARK: - property
    var presenter: ThrillerPresenterProtocol?
    var webView: WKWebView!
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter?.showThriller(in: webView)
    }
}
//MARK: - setup ui layout
private extension ThrillerViewController {
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
extension ThrillerViewController: ThrillerViewProtocol {
   
}
