//
//  MovieDetailsInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


protocol MovieDetailsInteractorProtocol: AnyObject {
    
}


class MovieDetailsInteractor {
    //MARK: property
    weak var presenter: MovieDetailsPresenterProtocol?
}
//MARK: - MovieDetailsInteractorProtocol
extension MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    
}
