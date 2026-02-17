//
//  SearchInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import UIKit


protocol SearchInteractorProtocol: AnyObject {
    func fetchSearchResult(search: String) async throws
}

class SearchInteractor {
    //MARK: - property
    weak var presenter: SearchPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let sessionID: String
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionID: String) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionID = sessionID
    }
}
//MARK: - SearchInteractorProtocol
extension SearchInteractor: SearchInteractorProtocol {
    func fetchSearchResult(search: String) async throws {
        
        let movies = try await withThrowingTaskGroup(of: MovieResult.self) { group in
            
            let session = URLSession.shared
            
            let request = try self.networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.searchMovie(apiKey: Constants.apiKey, title: search))
            
            group.addTask { [weak self, request] in
                
                guard let response = try await self?.networkManager.fetch(type: MovieResult.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return response
            }
           
            var movies: MovieResult?
            
            for try await moviesResponse in group {
                movies = moviesResponse
            }
            return movies
        }
        
        guard let moviesArray = movies?.results else { return }
        
        let posters = try await withThrowingTaskGroup(of: [Int : UIImage].self) { group in
            
            let session = URLSession.shared
           
            for movie in moviesArray {
                
                guard let url = URL(string: ImageURL.imagePath(path: movie.posterPath ?? "").url) else {
                    throw AppError.badURL
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.timeoutInterval = 10
                
                group.addTask { [weak self, request] in
                    if movie.posterPath == nil {
                        let image = UIImage(named: "image")!
                        return [movie.id ?? 0 : image]
                    } else {
                        guard let response = try await self?.imageDownloader.fetchImage(with: session, request: request) else {
                            throw AppError.invalidData
                        }
                        return [movie.id ?? 0 : response]
                    }
                }
            }
            var posters: [Int : UIImage] = [:]
            
            for try await result in group {
                posters.merge(result) { image, _ in image }
            }
            return posters
        }
        presenter?.showResults(movies: moviesArray, posters: posters)
    }
}
