//
//  WatchListViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchListViewProtocol: AnyObject {
    
}

class WatchListViewController: UIViewController {

    //MARK: - property
    var presenter: WatchListPresenterProtocol?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.customBackground
    }
}
//MARK: - UI layout
private extension WatchListViewController {
    
}
//MARK: -
extension WatchListViewController: WatchListViewProtocol {
    
}
