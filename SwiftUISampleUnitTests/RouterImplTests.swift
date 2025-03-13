//
//  RouterImplTests.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 13/03/25.
//

import XCTest
@testable import SwiftUISample

final class RouterImplTests: XCTestCase {
    
    var sut: RouterImpl!
    
    override func setUp() {
        super.setUp()
        sut = RouterImpl()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_InitialSelectedTab_IsHome() {
        XCTAssertEqual(sut.selectedTabIndex, Tab.home.rawValue, "Initial selected tab should be home")
    }
    
    func test_NavigateToRoute_WithinSameTab() {
        sut.navigate(to: .cart, switchTab: false)
        XCTAssertEqual(sut.homePath.count, 1, "Home path should have one element after navigation")
    }
    
    func test_NavigateToRoute_WithTabSwitch_ForValidTab() {
        sut.navigate(to: .categories, switchTab: true)
        XCTAssertEqual(sut.selectedTabIndex, Tab.categories.rawValue, "Tab should switch to Categories")
        XCTAssertEqual(sut.categoriesPath.count, 0, "Navigation stack should be empty after switching tabs")
    }
    
    func test_NavigateToRoute_WithTabSwitch_ForInvalidTab() {
        sut.navigate(to: .wishlist, switchTab: true)
        XCTAssertEqual(sut.selectedTabIndex, Tab.home.rawValue, "Tab should remain at home as wishlist is not a valid tab")
        XCTAssertEqual(sut.homePath.count, 0, "Navigation stack should shoud not update as navigation didn't happen")
    }
    
    func test_NavigationEventHandler_CalledOnNavigation() {
        var receivedEvent: NavigationEvent?
        sut.navigationEventHandler = { event in
            receivedEvent = event
        }
        
        sut.navigate(to: .wishlist)
        
        if case .didNavigate(let route) = receivedEvent {
            XCTAssertEqual(route, .wishlist, "Expected navigation event for wishlist")
        } else {
            XCTFail("Expected willNavigate event")
        }
    }
    
    func test_GoBack_RemovesLastNavigation() {
        sut.navigate(to: .cart)
        sut.goBack()
        XCTAssertEqual(sut.homePath.count, 0, "Home path should be empty after going back")
    }
    
    func test_ResetToRoot_ClearsNavigationForTab() {
        sut.navigate(to: .cart)
        sut.resetToRoot(for: .home)
        XCTAssertEqual(sut.homePath.count, 0, "Home path should be empty after resetToRoot")
    }
    
    func test_ResetAll_ClearsAllTabs() {
        sut.navigate(to: .cart)
        sut.navigate(to: .wishlist, switchTab: true)
        sut.resetAll()
        
        XCTAssertEqual(sut.homePath.count, 0, "Home path should be empty after resetAll")
        XCTAssertEqual(sut.categoriesPath.count, 0, "Categories path should be empty after resetAll")
        XCTAssertEqual(sut.myOrdersPath.count, 0, "My Orders path should be empty after resetAll")
        XCTAssertEqual(sut.accountPath.count, 0, "Account path should be empty after resetAll")
        XCTAssertEqual(sut.selectedTabIndex, Tab.home.rawValue, "Tab should reset to home after resetAll")
    }
}
