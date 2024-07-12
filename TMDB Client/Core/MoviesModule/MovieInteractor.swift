//
//  MovieInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit

protocol MovieInteractorProtocol: AnyObject {
    
}

class MovieInteractor {
    
    weak var presenter: MoviePresenterProtocol?
    
}
//MARK: - MovieInteractorProtocol
extension MovieInteractor: MovieInteractorProtocol {
    
}
