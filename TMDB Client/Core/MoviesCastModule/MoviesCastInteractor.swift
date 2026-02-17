//
//  MoviesCastInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit

protocol MoviesCastInteractorProtocol: AnyObject {
    func fetchActorInfo() async throws
    func fetchActorsFilmography() async throws
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
    var sessionId: String { get }
    var keychain: KeyChainManager { get }
}

class MoviesCastInteractor {
    //MARK: - property
    weak var presenter: MoviesCastPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let keychain: KeyChainManager
    let sessionId: String
    let person: Int
    let poster: UIImage
    //MARK: - lifecycle
    init(networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager, sessionId: String, person: Int, poster: UIImage) {
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
        self.keychain = keychain
        self.sessionId = sessionId
        self.person = person
        self.poster = poster
    }
}
//MARK: - MoviesCastInteractorProtocol
extension MoviesCastInteractor: MoviesCastInteractorProtocol {
    func fetchActorsFilmography() async throws {
        
        let movies = try await withThrowingTaskGroup(of: ActrorsMovies.self) { group in
            
            let session = URLSession.shared
            
            let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.moviesWithPersone(apiKey: Constants.apiKey, personeId: self.person))
            
            group.addTask { [request, weak self] in
                guard let result = try await self?.networkManager.fetch(type: ActrorsMovies.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result
            }
            
            var movieResult: [Movie] = []
            
            for try await result in group {
                movieResult.append(contentsOf: result.cast)
            }
            
            if movieResult.count > 15 {
                //Show less movies in main collection view, to avoid downloading a lot of posters
                let shortArray: [Movie] = movieResult.dropLast(movieResult.count / 3)
                return shortArray
            } else {
                //If number of movies not so big, show all available movies
                return movieResult
            }
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
                
                group.addTask { [request, weak self] in
                    if movie.posterPath == nil  {
                        let image = UIImage(named: "image")!
                        return [movie.id ?? 0 : image]
                    } else {
                        guard let result = try await self?.imageDownloader.fetchImage(with: session, request: request) else {
                            throw AppError.invalidData
                        }
                        return [movie.id ?? 0 : result]
                    }
                }
            }
            var result: [Int : UIImage] = [:]
            
            for try await posters in group {
                result.merge(posters) { image, _ in image }
            }
            return result
        }
        
        presenter?.showActorfilmography(movies: movies, posters: posters)
    }
    func fetchActorInfo() async throws {
        
        let session = URLSession.shared
        
        let request = try networkManager.requestFactory(type: NoBody(), urlData: MoviesUrls.actorDetails(apiKey: Constants.apiKey, actorId: person))
        
        guard let result = try await networkManager.fetch(type: Cast.self, session: session, request: request) else { return }
        
        presenter?.showInfo(actor: result, poster: self.poster)
    }
}
