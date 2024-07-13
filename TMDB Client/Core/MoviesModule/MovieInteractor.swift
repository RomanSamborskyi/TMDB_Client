//
//  MovieInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit

protocol MovieInteractorProtocol: AnyObject {
    func fetchMovies(with ulr: String) async throws
    func fetchGenres() async throws
    func fetchMovies(by genre: Int) async throws
}

class MovieInteractor {
    //MARK: - property
    weak var presenter: MoviePresenterProtocol?
    let networkManager = NetworkManager()
    let imageDownloader = ImageDownloader.instance
}
//MARK: - MovieInteractorProtocol
extension MovieInteractor: MovieInteractorProtocol {
    func fetchGenres() async throws {
        
    }
    func fetchMovies(by genre: Int) async throws {
        
    }
    func fetchMovies(with url: String) async throws {
        guard let url = URL(string: url) else {
            throw AppError.badURL
        }
        
      let movies = try await withThrowingTaskGroup(of: MovieResult.self) { group in
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
           
            var movies: [Movie] = []
            
            group.addTask { [request] in
                guard let result = try await self.networkManager.fetchGET(type: MovieResult.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result
            }
            
            for try await response in group {
                movies.append(contentsOf: response.results)
            }
          return movies
        }
        
        let images = try await withThrowingTaskGroup(of: [Int : UIImage].self) { group in
            
            var posters: [Int : UIImage] = [:]
            
            for movie in movies {
                
                guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")") else {
                    throw AppError.badURL
                }
                
                let session = URLSession.shared
                var request = URLRequest(url: url)
                request.timeoutInterval = 10
                request.httpMethod = "GET"
               
                
                group.addTask { [request] in
                    guard let image = try await self.imageDownloader.fetchImage(with: session, request: request) else {
                        throw AppError.invalidData
                    }
                    return [movie.id ?? 0 : image]
                }
            }
            
            for try await respone in group {
                posters.merge(respone) { img, _ in img}
            }
            
            return posters
        }
        
        presenter?.didMoviesFertched(movies: movies, with: images)
    }
}
