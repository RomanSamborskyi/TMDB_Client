//
//  MoviesInteractor_Tests.swift
//  TMDB Client_Tests
//
//  Created by Roman Samborskyi on 12.11.2024.
//

import XCTest
@testable import TMDB_Client

final class MoviesInteractor_Tests: XCTestCase {
    
    var moviesInteractor: MovieInteractorProtocol?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let sessionId = KeyChainManager.instance.get(for: Constants.sessionKey) else {
            XCTFail("session id is not found")
            return
        }
        self.moviesInteractor = MovieInteractor(networkManager: NetworkManager(), imageDownloader: ImageDownloader(), sessionId: sessionId)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.moviesInteractor = nil
    }
    
    func test_MoviesInteractor_sessionId_shouldNotToBeNill() {
        XCTAssertNotNil(moviesInteractor?.sessionId)
    }
    
    func test_MoviesInteractor_fetchMovies_shouldNotThrowAnError() async throws {
        do {
            try await moviesInteractor?.fetchMovies(with: MoviesUrls.topRated(key: Constants.apiKey))
        } catch let error as AppError {
            XCTAssertNil(error)
        }
    }
    
    func test_MoviesInteractor_fetchGenries_shouldNotThrowAnError() async throws {
        do {
            try await moviesInteractor?.fetchGenres()
        } catch let error as AppError {
            XCTAssertNil(error)
        }
    }
    
    func test_MoviesInteractor_fetchMoviesByGenries_shouldNotThrowAnError() async throws {
        do {
            try await moviesInteractor?.fetchMovies(by: DeveloperPreview.instance.action.id)
        } catch let error as AppError {
            XCTAssertNil(error)
        }
    }
}
