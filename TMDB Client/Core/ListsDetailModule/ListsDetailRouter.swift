//
//  ListsDetailRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 29.07.2024.
//

import Foundation


protocol ListsDetailRouterProtocol: AnyObject {
    
}

class ListsDetailRouter {
    //MARK: - prperty
    weak var view: ListsDetailViewController?
}
//MARK: - ListsDetailRouterProtocol
extension ListsDetailRouter: ListsDetailRouterProtocol {
    
}
