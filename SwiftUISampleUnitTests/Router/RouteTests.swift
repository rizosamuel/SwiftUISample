//
//  RouteTests.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 17/03/25.
//

import XCTest
@testable import SwiftUISample

class RouteTests: XCTestCase {
    
    func testHashableConformance() {
        var hasher1 = Hasher()
        var hasher2 = Hasher()
        var hasher3 = Hasher()
        
        let route1 = Route.home
        let route2 = Route.categories
        let route3 = Route.home  // Same as route1
        
        route1.hash(into: &hasher1)
        route2.hash(into: &hasher2)
        route3.hash(into: &hasher3)
        
        let hashValue1 = hasher1.finalize()
        let hashValue2 = hasher2.finalize()
        let hashValue3 = hasher3.finalize()
        
        XCTAssertEqual(hashValue1, hashValue3, "Hash values for identical cases should be the same")
        XCTAssertNotEqual(hashValue1, hashValue2, "Hash values for different cases should be different")
    }
    
    func testHashableForParameterizedCases() {
        var hasher1 = Hasher()
        var hasher2 = Hasher()

        let category1 = Category(id: "1", name: "Electronics", imageURL: "electronics.jpg")
        let category2 = Category(id: "2", name: "Books", imageURL: "books.jpg")
        let route1 = Route.category(category1)
        let route2 = Route.category(category2)

        route1.hash(into: &hasher1)
        route2.hash(into: &hasher2)

        let hashValue1 = hasher1.finalize()
        let hashValue2 = hasher2.finalize()

        XCTAssertNotEqual(hashValue1, hashValue2, "Different categories should have different hash values")
    }
    
    func testEquatableConformance() {
        let route1 = Route.home
        let route2 = Route.home
        let route3 = Route.categories
        
        XCTAssertEqual(route1, route2, "Identical cases should be equal")
        XCTAssertNotEqual(route1, route3, "Different cases should not be equal")
    }
    
    func testEquatableForParameterizedCases() {
        let category1 = Category(id: "1", name: "Electronics", imageURL: "electronics.jpg")
        let category2 = Category(id: "2", name: "Books", imageURL: "books.jpg")
        let route1 = Route.category(category1)
        let route2 = Route.category(category1)
        let route3 = Route.category(category2)
        
        XCTAssertEqual(route1, route2, "Routes with the same category should be equal")
        XCTAssertNotEqual(route1, route3, "Routes with different categories should not be equal")
    }
    
    func testToTabMapping() {
        XCTAssertEqual(Route.home.toTab, .home, "Home route should map to home tab")
        XCTAssertEqual(Route.categories.toTab, .categories, "Categories route should map to categories tab")
        XCTAssertEqual(Route.myOrders.toTab, .myOrders, "MyOrders route should map to myOrders tab")
        XCTAssertEqual(Route.account.toTab, .account, "Account route should map to account tab")
        XCTAssertNil(Route.cart.toTab, "Cart route should not have a tab mapping")
        XCTAssertNil(Route.settings.toTab, "Settings route should not have a tab mapping")
    }
}
