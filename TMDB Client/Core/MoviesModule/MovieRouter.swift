//
//  MovieRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit


protocol MovieRouterProtocol: AnyObject {
    
}

class MovieRouter {
    
    weak var view: MoviesViewController?
    
}
//MARK: - MovieRouterProtocol
extension MovieRouter: MovieRouterProtocol {
    
}
