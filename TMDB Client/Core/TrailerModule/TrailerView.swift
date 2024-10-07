//
//  ThrillerView.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 06.10.2024.
//

import UIKit
import WebKit

class TrailerView: UIView, WKUIDelegate {
    //MARK: - property
    var webView: WKWebView!
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func showTrailer(with url: String) {
        let url = URL(string: url)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
//MARK: - ui layout
private extension TrailerView {
    func setupLayout() {
        setupWebView()
    }
    func setupWebView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
    }
}
