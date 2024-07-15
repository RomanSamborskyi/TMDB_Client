//
//  ImageDownloader.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


class ImageDownloader {
    
    func fetchImage(with session: URLSession, request: URLRequest) async throws -> UIImage? {
        
        let (data, response) = try await session.data(for: request)
        let returnedData = try sessionHandler(data: data, response: response)
        
        return UIImage(data: returnedData)
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


