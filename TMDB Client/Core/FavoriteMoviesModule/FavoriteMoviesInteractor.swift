//
//  RatedMoviesInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit


protocol FavoriteMoviesInteractorProtocol: AnyObject {
    func fetchMovieStat(movieId: Int) async throws -> MovieStat
    func fetchRatedList() async throws
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
    var sessionId: String { get }
    var keychain: KeyChainManager { get }
}


class FavoriteMoviesInteractor {
    //MARK: - property
    weak var presenter: FavoriteMoviesPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let keychain: KeyChainManager
    let sessionId: String
    let accountId: Int
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, accountId: Int, keychain: KeyChainManager) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionId = sessionId
        self.accountId = accountId
        self.keychain = keychain
    }
}
//MARK: - RatedMoviesInteractorProtocol
extension FavoriteMoviesInteractor: FavoriteMoviesInteractorProtocol {
    func fetchMovieStat(movieId: Int) async throws -> MovieStat {
    
        let session = URLSession.shared

        let request = try networkManager.requestFactory(type: NoBody(), urlData: AccountUrl.accountState(key: Constants.apiKey, movieId: movieId, sessionId: self.sessionId))
        
        guard let result = try await self.networkManager.fetch(type: MovieStat.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        return result
    }
    func fetchRatedList() async throws {
        
        let watchList = try await withThrowingTaskGroup(of: [Movie].self) { group in
            
            let session = URLSession.shared
            let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.favoriteMovies(accaountId: self.accountId, sessionId: self.sessionId, apiKey: Constants.apiKey))
            
            group.addTask { [request, weak self] in
                guard let result = try await self?.networkManager.fetch(type: WatchlistResponse.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result.results ?? []
            }
            
            var returnedMovies: [Movie] = []
            
            for try await movies in group {
                returnedMovies = movies
            }
            return returnedMovies
        }
        
        let posters = try await withThrowingTaskGroup(of: [Int : UIImage].self) { group in
            
            var posters: [Int : UIImage] = [:]
            
            for movie in watchList {
                
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
            
            for try await poster in group {
                posters.merge(poster) { image, _ in image }
            }
            return posters
        }
        
        var mapedWatchlist: [Movie] = []
        
        for movie in watchList {
            let movieStatus = try await fetchMovieStat(movieId: movie.id ?? 0)
            var mov = movie
            mov.isFavorite = movieStatus.favorite ?? false
            mapedWatchlist.append(mov)
        }
        presenter?.didMoviesFetched(movies: mapedWatchlist, posters: posters)
    }
}
