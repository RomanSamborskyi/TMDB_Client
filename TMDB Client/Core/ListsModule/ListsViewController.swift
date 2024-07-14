//
//  ListsViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 13.07.2024.
//

import UIKit


protocol ListsViewControllerProtocol: AnyObject {
    
}

class ListsViewController: UIViewController {

    //MARK: - property
    var presenter: ListsPresenterProtocol?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .customBackground
        presenter?.viewControllerDidLoad()
    }
}
//MARK: - UI layout
private extension ListsViewController {
    
}
//MARK: - ListsViewControllerProtocol
extension ListsViewController: ListsViewControllerProtocol {
    
}
