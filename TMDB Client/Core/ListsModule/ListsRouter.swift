//
//  ListRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


protocol ListsRouterProtocol: AnyObject {
    
}

class ListsRouter {
    //MARK: - property
    weak var view: ListsViewController?
}
//MARK: - ListsRouterProtocol
extension ListsRouter: ListsRouterProtocol {
    
}
