//
//  LoginInteractor_Tests.swift
//  TMDB Client_Tests
//
//  Created by Roman Samborskyi on 07.11.2024.
//

import XCTest
@testable import TMDB_Client

final class LoginInteractor_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_LoginInteractor_createNewSession_shouldBeNil() async throws {
        
        let login = LoginInteractor()
        
        XCTAssertNil(login.newSession)
       
    }
    func test_LoginInteractor_createNewSession_shouldNotToBeNil() async throws {
        
        let login = LoginInteractor()
        
        try await login.sendLoginRequestWith(login: "romansamb", password: "Roman12345.")
        
        XCTAssertNotNil(login.newSession)
       
    }
    func test_LoginInteractor_createNewSession_shouldThrowAnError_incorrectUserNameOrPass() async throws {
        
        let login = LoginInteractor()
        
        do {
            try await login.sendLoginRequestWith(login: "romansb", password: "Roman12345.")
        } catch let error as AppError {
            XCTAssertEqual(error, AppError.incorrectUserNameOrPass)
        }
    }
    func test_LoginInteractor_fetchUserData_dataSuccessfullySaved() async throws {
        
        let login = LoginInteractor()
        
        let coreData = CoreDataManager.instance
        let keyChain = KeyChainManager.instance
       
        try await login.sendLoginRequestWith(login: "romansamb", password: "Roman12345.")
        
        let sessionId = login.newSession?.session_id
       
        _ = try await login.fetchUserData(sessionId: sessionId!)
        
        let savedUser = try coreData.fetchUserDetails()
        let accountID = keyChain.get(for: Constants.account_id)
        
        XCTAssertNotNil(accountID)
        XCTAssertEqual(accountID, String(savedUser?.id ?? 0))
        XCTAssertNotNil(savedUser)
    }
}
