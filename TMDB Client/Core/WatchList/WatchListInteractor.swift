//
//  WatchListInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 15.07.2024.
//

import UIKit


protocol WatchListInteractorProtocol: AnyObject {
    func fetchWatchList() async throws
}

class WatchListInteractor {
    //MARK: - property
    weak var presenter: WatchListPresenterProtocol?
    let networkManager = NetworkManager()
    let imageDownloader = ImageDownloader()
}
//MARK: - WatchListInteractorProtocol
extension WatchListInteractor: WatchListInteractorProtocol {
    func fetchWatchList() async throws {
        
        guard let url = URL(string: AccountUrl.watchList(accountId: 19306725, key: Constants.apiKey).url) else {
            throw AppError.badURL
        }
        
        let watchList = try await withThrowingTaskGroup(of: WatchListResponse.self) { group in
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            
            group.addTask { [request, weak self] in
                guard let result = try await self?.networkManager.fetchGET(type: WatchListResponse.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result
            }
            
            var returnedMovies: [Movie] = []
            
            for try await movies in group {
                returnedMovies.append(contentsOf: movies.results ?? [])
            }
            return returnedMovies
        }
        
        
    }
}
