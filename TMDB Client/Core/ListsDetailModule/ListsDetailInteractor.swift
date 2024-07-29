//
//  ListsDetailInteractor.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import Foundation


protocol ListsDetailInteractorProtocol: AnyObject {
    func fetchDetails() async throws
}

class ListsDetailInteractor {
    //MARK: - property
    weak var presenter: ListsDetailPresenterProtocol?
    private let networkManager = NetworkManager()
    let listId: Int
    //MARK: - lifecycle
    init(listId: Int) {
        self.listId = listId
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
    }
}
