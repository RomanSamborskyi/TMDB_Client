//
//  WatchListRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchlistRouterProtocol: AnyObject {
    
}

class WatchlistRouter {
    //MARK: - property
    weak var view: WatchlistViewController?
}
//MARK: - WatchListRouterProtocol
extension WatchlistRouter: WatchlistRouterProtocol {
    
}
