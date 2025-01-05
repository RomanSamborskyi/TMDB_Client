//
//  SearchRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import Foundation


protocol SearchRouterProtocol: AnyObject {
    
}

class SearchRouter {
    //MARK: - property
    weak var view: SearchViewControllerProtocol?
    //MARK: - lifecycle
}
//MARK: - SearchRouterProtocol
extension SearchRouter: SearchRouterProtocol {
    
}
