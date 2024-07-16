//
//  MovieDetailsRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


protocol MovieDetailsRouterProtocol: AnyObject {
    
}

class MovieDetailsRouter {
    //MARK: - property
    weak var view: MovieDetailsViewController?
}
//MARK: - MovieDetailsRouterProtocol
extension MovieDetailsRouter: MovieDetailsRouterProtocol {
    
}
