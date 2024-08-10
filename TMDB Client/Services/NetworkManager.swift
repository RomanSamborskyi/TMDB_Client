//
//  NetworkManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import Foundation


final class NetworkManager {
   
    func fetchGET<T: Codable>(type: T.Type, session: URLSession, request: URLRequest) async throws -> T? {
        
        let (data, response) = try await session.data(for: request)
        let returnedData = try sessionHandler(data: data, response: response)
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: returnedData)
    }
    
    private func sessionHandler(data: Data?, response: URLResponse) throws -> Data {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw AppError.badResponse
        }
        return data
    }
}
