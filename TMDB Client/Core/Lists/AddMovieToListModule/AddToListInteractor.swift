//
//  AddToListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.08.2024.
//

import UIKit


protocol AddToListInteractorProtocol: AnyObject {
    func addMovieToList(with id: Int) async throws
    func searchMovies(title: String) async throws
}


class AddToListInteractor {
    //MARK: property
    weak var presenter: AddToListPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let listId: Int
    let sessionId: String
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, listId: Int, sessionId: String) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.listId = listId
        self.sessionId = sessionId
    }
}
//MARK: - AddToListInteractorProtocol
extension AddToListInteractor: AddToListInteractorProtocol {
    func searchMovies(title: String) async throws {
        
        let movies = try await withThrowingTaskGroup(of: MovieResult.self) { group in
            
            let session = URLSession.shared

            let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.searchMovie(apiKey: Constants.apiKey, title: title.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""))
            
            group.addTask { [request, weak self] in
                guard let result = try await self?.networkManager.fetchGET(type: MovieResult.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result
            }
            
            var result: MovieResult?
            
            for try await response in group {
                result = response
            }
            return result
        }
        
        guard let moviesArray = movies?.results else { return }
        
        let posters = try await withThrowingTaskGroup(of: [Int : UIImage].self) { group in
            
            var posters: [Int : UIImage] = [:]
            
            for movie in moviesArray {
                
                guard let url = URL(string: ImageURL.imagePath(path: movie.posterPath ?? "").url) else {
                    throw AppError.badURL
                }
                
                let session = URLSession.shared
                let request = URLRequest(url: url)
                
                guard let poster = try await imageDownloader.fetchImage(with: session, request: request) else {
                    throw AppError.invalidData
                }
                
                posters[movie.id ?? 0] = poster
            }
            
            return posters
        }
        
        presenter?.didSearchResultFetched(movies: movies?.results ?? [], posters: posters)
    }
    func addMovieToList(with id: Int) async throws {
        
        let session = URLSession.shared

        let body = ["media_id" : id]
        
        let request = try networkManager.requestFactory(type: body, urlData: ListURL.addMovie(listId: listId, apiKey: Constants.apiKey, sessionId: sessionId))
        
        guard let _ = try await networkManager.fetchGET(type: ClearList.self, session: session, request: request) else {
            throw AppError.invalidData
        }
    }
}
