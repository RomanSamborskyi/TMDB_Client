//
//  WatchListRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchListRouterProtocol: AnyObject {
    
}

class WatchListRouter {
    //MARK: - property
    weak var view: WatchListViewController?
}
//MARK: - WatchListRouterProtocol
extension WatchListRouter: WatchListRouterProtocol {
    
}
