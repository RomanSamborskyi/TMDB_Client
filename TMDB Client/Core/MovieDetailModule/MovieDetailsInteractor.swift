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
}


class MovieDetailsInteractor {
    //MARK: property
    weak var presenter: MovieDetailsPresenterProtocol?
    let movieId: Int
    let poster: UIImage
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let keychain = KeyChainManager.instance
    //MARK: - lifecycle
    init(movieId: Int, poster: UIImage, networkManager: NetworkManager, imageDownloader: ImageDownloader) {
        self.movieId = movieId
        self.poster = poster
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
    }
}
//MARK: - MovieDetailsInteractorProtocol
extension MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    func addRate(rate: Double) async throws {
        
        guard let sessioId = keychain.get(for: Constants.sessionKey) else {
            throw AppError.invalidData
        }
        
        guard let url = URL(string: MoviesUrls.addRating(movieId: self.movieId, sessionId: sessioId, key: Constants.apiKey).url) else {
            throw AppError.badURL
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = Constants.addRatingHeaders
        
        let data = RateBody(value: rate)
        
        do {
            request.httpBody = try JSONEncoder().encode(data)
        } catch let error {
            print("Error of encoding data: \(error)")
        }
        
        guard let _ = try await networkManager.fetchGET(type: RateBody.self, session: session, request: request) else {
            throw AppError.invalidData
        }
    }
    func addToFavorite() async throws {
        
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
    func fetchMovieStat() async throws -> MovieStat {
        
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
    func addToWatchlist() async throws {
        
        guard let accoutID = keychain.get(for: Constants.account_id) else {
            throw AppError.incorrectAccoutId
        }
        
        guard let url = URL(string: "https://api.themoviedb.org/3/account/\(accoutID)/watchlist?api_key=\(Constants.apiKey)") else {
            throw AppError.badURL
        }
    
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = Constants.addToWatchListHeader
        
        let body = AddToWatchlist(media_type: "movie", media_id: movieId, watchlist: true)
        
        request.httpBody = try? JSONEncoder().encode(body)
        
        let _ = try await networkManager.fetchGET(type: AddToWatchlist.self, session: session, request: request)
        
    }
    func fetchMovieDetails() async throws {
        guard let url = URL(string: MoviesUrls.singleMovie(movieId: self.movieId, key: Constants.apiKey).url) else {
            throw AppError.badURL
        }
        
        let movie = try await withThrowingTaskGroup(of: MovieDetail.self) { group in
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
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
        
        let backdropPoster = try await withThrowingTaskGroup(of: UIImage.self) { group in
            
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(requesteedMovie.backdropPath ?? "")") else {
                throw AppError.badURL
            }
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
           
            
            group.addTask { [request, weak self] in
                guard let result = try await self?.imageDownloader.fetchImage(with: session, request: request) else {
                    throw AppError.invalidData
                }
                return result
            }
            
            var poster: UIImage?
            
            for try await image in group {
                poster = image
            }
            return poster
        }
        
        guard let backdrop = backdropPoster else {
            throw AppError.invalidData
        }
        
        let movieStat = try await fetchMovieStat()
        presenter?.didMovieFetched(movie: requesteedMovie, poster: poster, backdropPOster: backdrop, stat: movieStat)
    }
    
}
