//
//  NetworkManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import Foundation


final class NetworkManager {
    
    func requestFactory<BodyData: Codable>(type: BodyData, urlData: URLData) throws -> URLRequest {
        
        guard let  url = URL(string: urlData.url) else {
            throw AppError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = urlData.method.rawValue.uppercased()
        request.timeoutInterval = 10
        
        if let headers = urlData.headers {
            request.allHTTPHeaderFields = headers
        }
        
        if urlData.method.rawValue.uppercased() == "POST" || urlData.method.rawValue.uppercased() == "DELETE" {
            do {
                let bodyData = try JSONEncoder().encode(type)
                request.httpBody = bodyData
            } catch let error {
                print("Error of encoding nody data: \(error)")
            }
        }
        
        return request
    }
   
    func fetch<T: Codable>(type: T.Type, session: URLSession, request: URLRequest) async throws -> T? {
        
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
