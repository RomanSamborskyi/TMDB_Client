//
//  MovieInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit

protocol MovieInteractorProtocol: AnyObject {
    func fetchMovies(with ulr: URLData) async throws
    func fetchGenres() async throws
    func fetchMovies(by genre: Int) async throws
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
    var sessionId: String { get }
    var keychain: KeyChainManager { get }
}

class MovieInteractor {
    //MARK: - property
    weak var presenter: MoviePresenterProtocol?
    let networkManager: NetworkManager
    let keychain: KeyChainManager
    let imageDownloader: ImageDownloader
    let sessionId: String
    
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager, sessionId: String) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.keychain = keychain
        self.sessionId = sessionId
    }
}
//MARK: - MovieInteractorProtocol
extension MovieInteractor: MovieInteractorProtocol {
    func fetchGenres() async throws {
        
        let session = URLSession.shared
        let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.allGenres(key: Constants.apiKey))
        guard let response = try await networkManager.fetchGET(type: GenreResponse.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        presenter?.didGenreFetched(genre: response.genres)
    }
    func fetchMovies(by genre: Int) async throws {
        
        let movies = try await withThrowingTaskGroup(of: MovieResult.self) { group in
            
            let session = URLSession.shared
            let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.byGenre(key: Constants.apiKey, genre: genre))
            
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
    func fetchMovies(with url: URLData) async throws {
        
        let movies = try await withThrowingTaskGroup(of: MovieResult.self) { group in
            let session = URLSession.shared
            let request = try networkManager.requestFactory(type: NoBody(), urlData: url)
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
                    if movie.posterPath != nil {
                        guard let image = try await self.imageDownloader.fetchImage(with: session, request: request) else {
                            throw AppError.invalidData
                        }
                        return [movie.id ?? 0 : image]
                    } else {
                        let image = UIImage(named: "image")!
                        return [movie.id ?? 0 : image]
                    }
                }
            }
            
            for try await respone in group {
                posters.merge(respone) { img, _ in img}
            }
            
            return posters
        }
        await presenter?.didMoviesFertched(movies: movies, with: images)
    }
}
