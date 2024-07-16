//
//  MovieDetailsInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


protocol MovieDetailsInteractorProtocol: AnyObject {
    func fetchMovieDetails() async throws
}


class MovieDetailsInteractor {
    //MARK: property
    weak var presenter: MovieDetailsPresenterProtocol?
    let movieId: Int
    let poster: UIImage
    
    //MARK: - lifecycle
    init(movieId: Int, poster: UIImage) {
        self.movieId = movieId
        self.poster = poster
    }
}
//MARK: - MovieDetailsInteractorProtocol
extension MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    func fetchMovieDetails() async throws {
        
    }
}
