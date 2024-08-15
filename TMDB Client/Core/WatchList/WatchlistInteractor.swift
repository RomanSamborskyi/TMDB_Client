//
//  WatchListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchlistInteractorProtocol: AnyObject {
    func fetchWatchList() async throws
    func fetchMovieStat(movieId: Int) async throws -> MovieStat
    func addToFavorite(movieId: Int) async throws
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
}

class WatchlistInteractor {
    //MARK: - property
    weak var presenter: WatchlistPresenterProtocol?
    private var keychain = KeyChainManager.instance
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
    }
}
//MARK: - WatchListInteractorProtocol
extension WatchlistInteractor: WatchlistInteractorProtocol {
    func addToFavorite(movieId: Int) async throws {
        
        guard let accountID = Int(keychain.get(for: Constants.account_id) ?? "") else {
            throw AppError.incorrectAccoutId
        }
        
        guard let url = URL(string: MoviesUrls.addToFavorite(accoutId: accountID, key: Constants.apiKey).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = Constants.addToFavoriteHeader
        
        let body = AddToFavorite(media_type: "movie", media_id: movieId, favorite: true)
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let _ = try await networkManager.fetchGET(type: AddToFavorite.self, session: session, request: request)
        
    }
    func fetchMovieStat(movieId: Int) async throws -> MovieStat {
        
        guard let sessionID = keychain.get(for: Constants.sessionKey) else {
            throw AppError.badURL
        }
        guard let url = URL(string: AccountUrl.accountState(key: Constants.apiKey, movieId: movieId, sessionId: sessionID).url) else {
            throw AppError.badURL
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        guard let result = try await self.networkManager.fetchGET(type: MovieStat.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        return result
    }
    func fetchWatchList() async throws {
        
        guard let acoountID = Int(keychain.get(for: Constants.account_id) ?? "") else {
            throw AppError.incorrectAccoutId
        }
        
        guard let url = URL(string: AccountUrl.watchList(accountId: acoountID, key: Constants.apiKey).url) else {
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
                returnedMovies = movies
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
