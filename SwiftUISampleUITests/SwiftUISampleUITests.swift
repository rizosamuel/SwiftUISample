//
//  SwiftUISampleUITests.swift
//  SwiftUISampleUITests
//
//  Created by Rijo Samuel on 12/03/25.
//

import XCTest

final class SwiftUISampleUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testHomeViewExists() {
        let homeView = app.scrollViews["HomeView"]
        XCTAssertTrue(homeView.exists, "HomeView should be visible on launch")
    }
    
    func testNavigationToHome() {
        let homeTab = app.buttons["Home"]
        XCTAssertTrue(homeTab.exists, "Home tab should exist")
        homeTab.tap()
        
        let homeView = app.scrollViews["HomeView"]
        XCTAssertTrue(homeView.exists, "Should navigate to HomeView")
    }
    
    func testNavigationToCategories() {
        let categoriesTab = app.buttons["Categories"]
        XCTAssertTrue(categoriesTab.exists, "Categories tab should exist")
        categoriesTab.tap()
        
        let categoriesView = app.scrollViews["CategoriesView"]
        XCTAssertTrue(categoriesView.exists, "Should navigate to CategoriesView")
    }
    
    func testNavigationToMyOrders() {
        let ordersTab = app.buttons["My Orders"]
        XCTAssertTrue(ordersTab.exists, "Orders tab should exist")
        ordersTab.tap()
        
        let ordersView = app.otherElements["OrdersView"]
        XCTAssertTrue(ordersView.exists, "Should navigate to OrdersView")
    }
    
    func testNavigationToAccount() {
        let accountTab = app.buttons["Account"]
        XCTAssertTrue(accountTab.exists, "Account tab should exist")
        accountTab.tap()
        
        let accountView = app.otherElements["AccountView"]
        XCTAssertTrue(accountView.exists, "Should navigate to AccountView")
    }
    
    func testNavigationToWishlist() {
        let wishlistButton = app/*@START_MENU_TOKEN@*/.buttons["Wishlist"]/*[[".otherElements[\"Love\"]",".buttons[\"Love\"]",".buttons[\"Wishlist\"]",".otherElements[\"Wishlist\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(wishlistButton.exists, "Wishlist button should exist")
        wishlistButton.tap()
        
        let wishlistText = app/*@START_MENU_TOKEN@*/.staticTexts["WishlistView"]/*[[".staticTexts[\"No products in your wishlist\"]",".staticTexts[\"WishlistView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let wishlistViewImage = app/*@START_MENU_TOKEN@*/.images["WishlistView"]/*[[".images[\"Love\"]",".images[\"WishlistView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(wishlistText.exists, "Should navigate to WishlistView")
        XCTAssertTrue(wishlistViewImage.exists, "Should navigate to WishlistView")
    }
    
    func testNavigationToNotifications() {
        let notificationsTab = app.buttons["Notifications"]
        XCTAssertTrue(notificationsTab.exists, "Notifications button should exist")
        notificationsTab.tap()
        
        let notificationsText = app.staticTexts["NotificationsView"]
        let notificationsViewImage = app.images["NotificationsView"]
        XCTAssertTrue(notificationsText.exists, "Should navigate to NotificationsView")
        XCTAssertTrue(notificationsViewImage.exists, "Should navigate to NotificationsView")
    }
    
    func testNavigationToCart() {
        let cartTab = app.buttons["Cart"]
        XCTAssertTrue(cartTab.exists, "Cart button should exist")
        cartTab.tap()
        
        let cartText = app.staticTexts["CartView"]
        let cartViewImage = app.images["CartView"]
        XCTAssertTrue(cartText.exists, "Should navigate to CartView")
        XCTAssertTrue(cartViewImage.exists, "Should navigate to CartView")
    }
    
    func testNavigationToSettings() {
        let accountTab = app.buttons["Account"]
        XCTAssertTrue(accountTab.exists, "Account tab should exist")
        accountTab.tap()
        
        let accountView = app.otherElements["AccountView"]
        XCTAssertTrue(accountView.exists, "Should navigate to AccountView")
        
        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Account"].tap()
        app.collectionViews.buttons["Settings"].tap()
                        
    }
}
