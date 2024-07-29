//
//  ListsDetailViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import UIKit

protocol ListsDetailViewProtocol: AnyObject {
    
}

class ListsDetailViewController: UIViewController {

    //MARK: - property
    var presenter: ListsDetailPresenterProtocol?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
//MARK: - ListsViewProtocol
extension ListsDetailViewController: ListsDetailViewProtocol {
    
}
