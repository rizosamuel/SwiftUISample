//
//  AuthenticationViewModelTests.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import XCTest
@testable import SwiftUISample

final class AuthenticationViewModelTests: XCTestCase {

    func testAuthenticationSuccess() {
        let mockRepo = MockBiometricsRepository()
        mockRepo.shouldSucceed = true
        let viewModel = AuthenticationViewModel(biometricsRepo: mockRepo)
        viewModel.authenticateUser()
        
        let expectation = XCTestExpectation(description: "Wait for authentication result")
        DispatchQueue.main.async {
            XCTAssertTrue(viewModel.isAuthenticated, "isAuthenticated should be true after successful authentication")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testAuthenticationFailure() {
        let mockRepo = MockBiometricsRepository()
        mockRepo.shouldSucceed = false
        let viewModel = AuthenticationViewModel(biometricsRepo: mockRepo)
        viewModel.authenticateUser()
        
        let expectation = XCTestExpectation(description: "Wait for authentication result")
        DispatchQueue.main.async {
            XCTAssertFalse(viewModel.isAuthenticated, "isAuthenticated should be false after failed authentication")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
