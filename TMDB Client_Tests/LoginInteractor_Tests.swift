//
//  LoginInteractor_Tests.swift
//  TMDB Client_Tests
//
//  Created by Roman Samborskyi on 07.11.2024.
//

import XCTest
@testable import TMDB_Client

final class LoginInteractor_Tests: XCTestCase {
    
    var loginInteractor: LoginInteractorProtocol?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginInteractor = LoginInteractor()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loginInteractor = nil
    }
    func test_LoginInteractor_createNewSession_shouldBeNil() async throws {
        
        XCTAssertNil(loginInteractor?.newSession)
       
    }
    func test_LoginInteractor_createNewSession_shouldNotToBeNil() async throws {
        
        try await loginInteractor?.sendLoginRequestWith(login: "romansamb", password: "Roman12345.")
        
        XCTAssertNotNil(loginInteractor?.newSession)
       
    }
    func test_LoginInteractor_createNewSession_shouldThrowAnError_incorrectUserNameOrPass() async throws {
        
        do {
            try await loginInteractor?.sendLoginRequestWith(login: "romansb", password: "Roman12345.")
        } catch let error as AppError {
            XCTAssertEqual(error, AppError.incorrectUserNameOrPass)
        }
    }
    func test_LoginInteractor_fetchUserData_dataSuccessfullySaved() async throws {
        
        let coreData = CoreDataManager.instance
       
        try await loginInteractor?.sendLoginRequestWith(login: "romansamb", password: "Roman12345.")
        
        let sessionId = loginInteractor?.newSession?.session_id
       
        _ = try await loginInteractor?.fetchUserData(sessionId: sessionId!)
        
        let savedUser = try coreData.fetchUserDetails()
        let accountID = loginInteractor?.keychain.get(for: Constants.account_id)
        
        XCTAssertNotNil(accountID)
        XCTAssertEqual(accountID, String(savedUser?.id ?? 0))
        XCTAssertNotNil(savedUser)
    }
}
