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
    var sessionId: String { get }
}

class WatchlistInteractor {
    //MARK: - property
    weak var presenter: WatchlistPresenterProtocol?
    private var keychain = KeyChainManager.instance
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let sessionId: String
    var isFetched: Bool?
    
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionId = sessionId
    }
}
//MARK: - WatchListInteractorProtocol
extension WatchlistInteractor: WatchlistInteractorProtocol {
    func addToFavorite(movieId: Int) async throws {
        
        guard let accountID = Int(keychain.get(for: Constants.account_id) ?? "") else {
            throw AppError.incorrectAccoutId
        }
  
        let session = URLSession.shared
 
        let body = AddToFavorite(media_type: "movie", media_id: movieId, favorite: true)
        
        let request = try networkManager.requestFactory(type: body, urlData: MoviesUrls.addToFavorite(accoutId: accountID, key: Constants.apiKey, sessionId: self.sessionId))
        
        let _ = try await networkManager.fetchGET(type: AddToFavorite.self, session: session, request: request)
        
    }
    func fetchMovieStat(movieId: Int) async throws -> MovieStat {
        
        guard let sessionID = keychain.get(for: Constants.sessionKey) else {
            throw AppError.badURL
        }

        let session = URLSession.shared

        let request = try networkManager.requestFactory(type: NoBody(), urlData: AccountUrl.accountState(key: Constants.apiKey, movieId: movieId, sessionId: sessionID))
        
        guard let result = try await self.networkManager.fetchGET(type: MovieStat.self, session: session, request: request) else {
            throw AppError.invalidData
        }
        
        return result
    }
    func fetchWatchList() async throws {
        
        guard let acoountID = Int(keychain.get(for: Constants.account_id) ?? "") else {
            throw AppError.incorrectAccoutId
        }
        
        self.isFetched = false
        
        let watchList = try await withThrowingTaskGroup(of: [Movie].self) { group in
            
            let session = URLSession.shared
            let request = try networkManager.requestFactory(type: NoBody(), urlData: AccountUrl.watchList(accountId: acoountID, key: Constants.apiKey, sessionId: self.sessionId))
            
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
