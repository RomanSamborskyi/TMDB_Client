//
//  ProfileInteractor_Tests.swift
//  TMDB Client_Tests
//
//  Created by Roman Samborskyi on 09.11.2024.
//

import XCTest
@testable import TMDB_Client

final class ProfileInteractor_Tests: XCTestCase {

    var profileInteractor: ProfileInteractorProtocol?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let sessionId = KeyChainManager.instance.get(for: Constants.sessionKey) else {
            XCTFail("session id is not found")
            return
        }
        profileInteractor = ProfileInteractor(sessionId: sessionId, networkManager: NetworkManager(), imageDownloader: ImageDownloader())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        profileInteractor = nil
    }
    
    func test_ProfileInteractor_downloadUserData_shouldNotBeNil() async throws {
        
       let userTuple = try await profileInteractor?.downloadUserData()
        
        let user = userTuple?.0
        let avatar = userTuple?.1
        
        XCTAssertNotNil(user)
        XCTAssertNotNil(avatar)
    }
    
    func test_ProfileInteractor_fetchUserData_shouldNotBeNill() async throws {
        
        try await profileInteractor?.fetchUserData()
        
        let user = try CoreDataManager.instance.fetchUserDetails()
        let avatar = UIImage(data: user?.uiImageAvatar ?? Data())
        
        XCTAssertNotNil(user)
        XCTAssertNotNil(avatar)
    }
    
    func test_ProfileInteractor_logout_shouldBeNill() async throws {
        
        try await profileInteractor?.logout()
        
        let user = try CoreDataManager.instance.fetchUserDetails()
        let avatar = UIImage(data: user?.uiImageAvatar ?? Data())
        
        let sessioID = KeyChainManager.instance.get(for: Constants.sessionKey)
        
        let accoutID = KeyChainManager.instance.get(for: Constants.account_id)
        
        XCTAssertNil(sessioID)
        XCTAssertNil(accoutID)
        
        XCTAssertNil(user)
        XCTAssertNil(avatar)
    }
}
