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
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
}

class MovieInteractor {
    //MARK: - property
    weak var presenter: MoviePresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
    }
}
//MARK: - MovieInteractorProtocol
extension MovieInteractor: MovieInteractorProtocol {
    func fetchGenres() async throws {
        
        guard let url = URL(string: MoviesUrls.allGenres(key: Constants.apiKey).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        guard let response = try await networkManager.fetchGET(type: GenreResponse.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        presenter?.didGenreFetched(genre: response.genres)
    }
    func fetchMovies(by genre: Int) async throws {
        
        let movies = try await withThrowingTaskGroup(of: MovieResult.self) { group in
            
            guard let url = URL(string: MoviesUrls.byGenre(key: Constants.apiKey, genre: genre).url) else {
                throw AppError.badURL
            }
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            group.addTask { [request] in
                guard let result = try await self.networkManager.fetchGET(type: MovieResult.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result
            }
            
            var movies: [Movie] = []
            
            for try await movie in group {
                movies.append(contentsOf: movie.results)
            }
            return movies
        }
        
        let posters = try await withThrowingTaskGroup(of: [Int : UIImage].self) { group in
            
            for movie in movies {
                guard let url = URL(string: ImageURL.imagePath(path: movie.posterPath ?? "").url) else {
                    throw AppError.badURL
                }
                
                let session = URLSession.shared
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.timeoutInterval = 10
                
                group.addTask { [request, weak self] in
                    guard let result = try await self?.imageDownloader.fetchImage(with: session, request: request) else {
                        throw AppError.invalidData
                    }
                    return [movie.id ?? 0 : result]
                }
            }
            
            var images: [Int : UIImage] = [:]
            
            for try await poster in group {
                images.merge(poster) { image, _ in image }
            }
            
            return images
        }
        presenter?.didMoviesByGenreFetched(movie: movies, with: posters)
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
