//
//  SettingsViewModelTests.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import XCTest
@testable import SwiftUISample

final class SettingsViewModelTests: XCTestCase {

    func testInitialState_AppLockDisabledByDefault() {
        let mockBiometricsRepo = MockBiometricsRepository()
        let mockUserDefaultsRepo = MockUserDefaultsRepository()
        
        // Ensure no value is set in UserDefaults (default case)
        let viewModel = SettingsViewModel(biometricsRepo: mockBiometricsRepo, userDefaultsRepo: mockUserDefaultsRepo)
        
        XCTAssertFalse(viewModel.isAppLockEnabled, "isAppLockEnabled should be false if no previous value is stored in UserDefaults")
    }
    
    func testInitialState_AppLockEnabledFromUserDefaults() {
        let mockBiometricsRepo = MockBiometricsRepository()
        let mockUserDefaultsRepo = MockUserDefaultsRepository()
        
        // Simulate app lock enabled in UserDefaults
        mockUserDefaultsRepo.save(true, forKey: Constants.IS_APP_LOCK_KEY)
        
        let viewModel = SettingsViewModel(biometricsRepo: mockBiometricsRepo, userDefaultsRepo: mockUserDefaultsRepo)
        
        XCTAssertTrue(viewModel.isAppLockEnabled, "isAppLockEnabled should be true if previously stored in UserDefaults")
    }

    func testToggleAppLock_Disable() {
        let mockBiometricsRepo = MockBiometricsRepository()
        let mockUserDefaultsRepo = MockUserDefaultsRepository()
        
        let viewModel = SettingsViewModel(biometricsRepo: mockBiometricsRepo, userDefaultsRepo: mockUserDefaultsRepo)
        
        viewModel.toggleAppLock(isEnabled: false)
        
        XCTAssertFalse(viewModel.isAppLockEnabled, "isAppLockEnabled should be false after disabling")
        XCTAssertFalse(mockUserDefaultsRepo.get(forKey: Constants.IS_APP_LOCK_KEY, type: Bool.self) ?? true, "UserDefaults should store false when disabling app lock")
    }

    func testToggleAppLock_Enable_SuccessfulBiometricAuthentication() {
        let mockBiometricsRepo = MockBiometricsRepository()
        mockBiometricsRepo.shouldSucceed = true // Simulate successful biometric authentication
        
        let mockUserDefaultsRepo = MockUserDefaultsRepository()
        let viewModel = SettingsViewModel(biometricsRepo: mockBiometricsRepo, userDefaultsRepo: mockUserDefaultsRepo)
        
        let expectation = XCTestExpectation(description: "Wait for authentication result")
        
        viewModel.toggleAppLock(isEnabled: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(viewModel.isAppLockEnabled, "isAppLockEnabled should be true after successful biometric authentication")
            XCTAssertTrue(mockUserDefaultsRepo.get(forKey: Constants.IS_APP_LOCK_KEY, type: Bool.self) ?? false, "UserDefaults should store true when enabling app lock")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testToggleAppLock_Enable_FailedBiometricAuthentication() {
        let mockBiometricsRepo = MockBiometricsRepository()
        mockBiometricsRepo.shouldSucceed = false // Simulate failed biometric authentication
        
        let mockUserDefaultsRepo = MockUserDefaultsRepository()
        let viewModel = SettingsViewModel(biometricsRepo: mockBiometricsRepo, userDefaultsRepo: mockUserDefaultsRepo)
        
        let expectation = XCTestExpectation(description: "Wait for authentication result")
        
        viewModel.toggleAppLock(isEnabled: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(viewModel.isAppLockEnabled, "isAppLockEnabled should remain false after failed biometric authentication")
            XCTAssertFalse(mockUserDefaultsRepo.get(forKey: Constants.IS_APP_LOCK_KEY, type: Bool.self) ?? true, "UserDefaults should store false when biometric authentication fails")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
