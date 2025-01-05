//
//  SearchInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 05.01.2025.
//

import UIKit


protocol SearchInteractorProtocol: AnyObject {
    func fetchSearchResult() async throws
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
    func fetchSearchResult() async throws {
        
        let movies = try await withThrowingTaskGroup(of: Movie.self) { group in
            
            let session = URLSession.shared
            
            let request = try self.networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.searchMovie(apiKey: Constants.apiKey, title: ""))
            
            group.addTask { [weak self, request] in
                
                guard let response = try await self?.networkManager.fetchGET(type: Movie.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return response
            }
           
            var movies: [Movie] = []
            
            for try await moviesResponse in group {
                movies.append(moviesResponse)
            }
            return movies
        }
        
        let posters = try await withThrowingTaskGroup(of: [Int : UIImage].self) { group in
            
            let session = URLSession.shared
            
            for movie in movies {
                
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
    }
}
