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
    func fetchCrew() async throws
    func fetchReviews() async throws
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
    func fetchReviews() async throws {
        let reviews = try await withThrowingTaskGroup(of: ReviewResponse.self) { group in
            
            let session = URLSession.shared
            let requset = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.reviews(movieId: self.movieId, key: Constants.apiKey))
            
            group.addTask { [requset, weak self] in
                guard let result = try await self?.networkManager.fetchGET(type: ReviewResponse.self, session: session, request: requset) else {
                    throw AppError.invalidData
                }
                return result
            }
            
            var result: ReviewResponse?
            
            for try await reviews in group {
                result = reviews
            }
            return result
        }
        
        guard let reviews = reviews?.results else { return }
        
        let avatars = try await withThrowingTaskGroup(of: [String : UIImage].self) { group in
            var photos: [String: UIImage] = [:]
            
            for review in reviews {
                
                guard let url = URL(string: ImageURL.imagePath(path: review.authorDetails.avatarPath ?? "").url) else {
                    throw AppError.badURL
                }
                
                let session = URLSession.shared
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.timeoutInterval = 10
                
                group.addTask { [request, weak self] in
                    if review.authorDetails.avatarPath == nil  {
                        let image = UIImage(named: "image")!
                        return [review.id : image]
                    } else {
                        guard let result = try await self?.imageDownloader.fetchImage(with: session, request: request) else {
                            throw AppError.invalidData
                        }
                        return [review.id : result]
                    }
                }
            }
            for try await photo in group {
                photos.merge(photo) { _, image in image }
            }
            return photos
        }
        
        presenter?.showReviews(reviews: reviews, avatar: avatars)
    }
    func fetchCrew() async throws {
        
        let crew = try await withThrowingTaskGroup(of: [Cast].self) { group in
            let session = URLSession.shared
            let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.cast(movieId: self.movieId, key: Constants.apiKey))
            
            group.addTask { [request, weak self] in
                guard let result = try await self?.networkManager.fetchGET(type: CastResponse.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result.cast
            }
            
            var crew: [Cast] = []
            
            for try await result in group {
                crew.append(contentsOf: result)
            }
            return crew
        }
        
        let photos = try await withThrowingTaskGroup(of: [Int: UIImage].self) { group in
            
            var photos: [Int: UIImage] = [:]
            
            for personePhoto in crew {
                
                guard let url = URL(string: ImageURL.imagePath(path: personePhoto.profilePath ?? "").url) else {
                    throw AppError.badURL
                }
                
                let session = URLSession.shared
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.timeoutInterval = 10
                
                group.addTask { [request, weak self] in
                    if personePhoto.profilePath == nil  {
                        let image = UIImage(named: "image")!
                        return [personePhoto.id ?? 0 : image]
                    } else {
                        guard let result = try await self?.imageDownloader.fetchImage(with: session, request: request) else {
                            throw AppError.invalidData
                        }
                        return [personePhoto.id ?? 0 : result]
                    }
                }
            }
            for try await photo in group {
                photos.merge(photo) { _, image in image }
            }
            
            return photos
        }
        
        presenter?.didCrewFetched(with: crew, photos: photos)
    }
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
