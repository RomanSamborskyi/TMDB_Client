//
//  WatchListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchlistInteractorProtocol: AnyObject {
    func fetchWatchList() async throws
}

class WatchlistInteractor {
    //MARK: - property
    weak var presenter: WatchlistPresenterProtocol?
    let networkManager = NetworkManager()
    let imageDownloader = ImageDownloader()
}
//MARK: - WatchListInteractorProtocol
extension WatchlistInteractor: WatchlistInteractorProtocol {
    func fetchWatchList() async throws {
        
        guard let url = URL(string: AccountUrl.watchList(accountId: 19306725, key: Constants.apiKey).url) else {
            throw AppError.badURL
        }
        
        let watchList = try await withThrowingTaskGroup(of: [Movie].self) { group in
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = Constants.watchListheader
            
            group.addTask { [request, weak self] in
                guard let result = try await self?.networkManager.fetchGET(type: WatchlistResponse.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result.results ?? []
            }
            
            var returnedMovies: [Movie] = []
            
            for try await movies in group {
                returnedMovies.append(contentsOf: movies)
            }
            return returnedMovies
        }
        
        let posters = try await withThrowingTaskGroup(of: [Int : UIImage].self) { group in
            
            var posters: [Int : UIImage] = [:]
            
            for movie in watchList {
                
                guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")") else {
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
            
            for try await poster in group {
                posters.merge(poster) { image, _ in image }
            }
            return posters
        }
        
        presenter?.didMoviesFetched(movies: watchList, posters: posters)
    }
}
