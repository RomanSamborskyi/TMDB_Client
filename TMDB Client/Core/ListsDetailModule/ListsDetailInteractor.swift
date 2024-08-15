//
//  ListsDetailInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import UIKit


protocol ListsDetailInteractorProtocol: AnyObject {
    func fetchDetails() async throws
    var networkManager: NetworkManager { get }
    var imageDownloader: ImageDownloader { get }
    var listId: Int { get } 
}

class ListsDetailInteractor {
    //MARK: - property
    weak var presenter: ListsDetailPresenterProtocol?
    let networkManager: NetworkManager
    let imageDownloader: ImageDownloader
    let listId: Int
    //MARK: - lifecycle
    init(listId: Int, networkManager: NetworkManager, imageDownloader: ImageDownloader) {
        self.listId = listId
        self.networkManager = networkManager
        self.imageDownloader = imageDownloader
    }
}
//MARK: - ListsDetailInteractorProtocol
extension ListsDetailInteractor: ListsDetailInteractorProtocol {
    func fetchDetails() async throws {
        let list = try await withThrowingTaskGroup(of: ListDetail.self) { group in
            
            guard let url = URL(string: ListURL.listDetail(listsId: self.listId, apiKey: Constants.apiKey).url) else {
                throw AppError.badURL
            }
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            
            group.addTask { [request, weak self] in
                guard let result = try await self?.networkManager.fetchGET(type: ListDetail.self, session: session, request: request) else {
                    throw AppError.invalidData
                }
                return result
            }
            var list: ListDetail?
            
            for try await result in group {
                list = result
            }
            return list
        }
        
        let posters = try await withThrowingTaskGroup(of: [Int : UIImage].self) { group in
            
            var posters: [Int : UIImage] = [:]
            
            if let movies = list?.items {
                for movie in movies {
                    
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
            }
            
            for try await postersDictionary in group {
                posters.merge(postersDictionary) { image, _ in image }
            }
            
            return posters
        }
        
        guard let list = list else {
            throw AppError.invalidData
        }
        
        presenter?.didListFetched(list: list, posters: posters)
    }
}
