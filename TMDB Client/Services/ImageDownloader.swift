//
//  ImageDownloader.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


class ImageDownloader {
    
    private lazy var cache = CacheManager.instance
    
    func fetchImage(with session: URLSession, request: URLRequest) async throws -> UIImage? {
        
        if let image = cache.getImage(for: request.url?.description ?? "") {
            return image
        } else {
            let (data, response) = try await session.data(for: request)
            let returnedData = try sessionHandler(data: data, response: response)
            
            guard let image = UIImage(data: returnedData) else {
                throw AppError.invalidData
            }
            cache.add(image: image, with: request.url?.description ?? "")
            return image
        }
    }
    
    private func sessionHandler(data: Data?, response: URLResponse) throws -> Data {
        guard  let response = response as? HTTPURLResponse else {
            throw AppError.badResponse
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw AppError.invalidStatusCode(code: response.statusCode)
        }
        guard let data = data else {
            throw AppError.invalidData
        }
        return data
    }
}


