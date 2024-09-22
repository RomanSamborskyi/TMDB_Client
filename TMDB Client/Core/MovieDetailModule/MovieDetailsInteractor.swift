//
//  MovieDetailsInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import UIKit


protocol MovieDetailsInteractorProtocol: AnyObject {
    func fetchMovieDetails() async throws
    func addToWatchlist() async throws
    func fetchMovieStat() async throws -> MovieStat
    func addToFavorite() async throws
    func addRate(rate: Double) async throws
    var sessionId: String { get }
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
    var movieId: Int { get }
}


class MovieDetailsInteractor {
    //MARK: property
    weak var presenter: MovieDetailsPresenterProtocol?
    let movieId: Int
    let poster: UIImage
    let sessionId: String
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let keychain = KeyChainManager.instance
    
    //MARK: - lifecycle
    init(movieId: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String) {
        self.movieId = movieId
        self.poster = poster
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.sessionId = sessionId
    }
}
//MARK: - MovieDetailsInteractorProtocol
extension MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    func addRate(rate: Double) async throws {
        
        guard let sessioId = keychain.get(for: Constants.sessionKey) else {
            throw AppError.invalidData
        }
        
        let session = URLSession.shared

        let data = RateBody(value: rate)
        
        let request = try networkManager.requestFactory(type: data, urlData: MoviesUrls.addRating(movieId: self.movieId, sessionId: sessioId, key: Constants.apiKey))
        
        guard let _ = try await networkManager.fetchGET(type: RateBody.self, session: session, request: request) else {
            throw AppError.invalidData
        }
    }
    func addToFavorite() async throws {
        
        guard let accountID = Int(keychain.get(for: Constants.account_id) ?? "") else {
            throw AppError.incorrectAccoutId
        }
        
        let session = URLSession.shared

        let body = AddToFavorite(media_type: "movie", media_id: movieId, favorite: true)

        let request = try networkManager.requestFactory(type: body, urlData:  MoviesUrls.addToFavorite(accoutId: accountID, key: Constants.apiKey, sessionId: self.sessionId))
        
        let _ = try await networkManager.fetchGET(type: AddToFavorite.self, session: session, request: request)
        
    }
    func fetchMovieStat() async throws -> MovieStat {
        
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
    func addToWatchlist() async throws {
        
        guard let accoutID = Int(keychain.get(for: Constants.account_id) ?? "") else {
            throw AppError.incorrectAccoutId
        }
        
        let session = URLSession.shared

        let body = AddToWatchlist(media_type: "movie", media_id: movieId, watchlist: true)
    
        let request = try networkManager.requestFactory(type: body, urlData: MoviesUrls.addToWatchList(accoutId: accoutID, apiKey: Constants.apiKey, sessionId: self.sessionId))
        
        let _ = try await networkManager.fetchGET(type: AddToWatchlist.self, session: session, request: request)
        
    }
    func fetchMovieDetails() async throws {
        
        let movieStat = try await fetchMovieStat()

        let movie = try await withThrowingTaskGroup(of: MovieDetail.self) { group in
            
            let session = URLSession.shared
            let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.singleMovie(movieId: self.movieId, key: Constants.apiKey))
            
            group.addTask { [request, weak self] in
                guard let result = try await self?.networkManager.fetchGET(type: MovieDetail.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result
            }
            
            var returnedMovie: MovieDetail?
            
            for try await movie in group {
                returnedMovie = movie
            }
            return returnedMovie
        }
        
        guard let requesteedMovie = movie else {
            throw AppError.invalidData
        }
        
        presenter?.didMovieFetched(movie: requesteedMovie, poster: poster, stat: movieStat)
    }
}
