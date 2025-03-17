//
//  HomeViewModelTests.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 13/03/25.
//

import XCTest
@testable import SwiftUISample

class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        sut = HomeViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_FeaturedProducts_LoadedSuccessfully() {
        // Given: Expected product count
        let expectedProductCount = 3
        
        // When: The view model is initialized
        
        // Then: Ensure the featured products array is populated
        XCTAssertEqual(sut.featuredProducts.count, expectedProductCount, "Expected \(expectedProductCount) featured products, but got \(sut.featuredProducts.count)")
        XCTAssertEqual(sut.featuredProducts[0].id, "1")
    }
    
    func test_Categories_LoadedSuccessfully() {
        // Given: Expected category count
        let expectedCategoryCount = 4
        
        // When: The view model is initialized
        
        // Then: Ensure the categories array is populated
        XCTAssertEqual(sut.categories.count, expectedCategoryCount, "Expected \(expectedCategoryCount) categories, but got \(sut.categories.count)")
    }
    
    func test_FeaturedProducts_ContainExpectedData() {
        // Given: Expected product names
        let expectedProductNames = ["Wireless Headphones", "Smart Watch", "Portable Speaker"]
        
        // When: The view model is initialized
        let actualProductNames = sut.featuredProducts.map { $0.name }
        
        // Then: Ensure product names match expected values
        XCTAssertEqual(actualProductNames, expectedProductNames, "Featured product names do not match expected values")
    }
    
    func test_Categories_ContainExpectedData() {
        // Given: Expected category names
        let expectedCategoryNames = ["Electronics", "Clothing", "Home & Kitchen", "Beauty"]
        
        // When: The view model is initialized
        let actualCategoryNames = sut.categories.map { $0.name }
        
        // Then: Ensure category names match expected values
        XCTAssertEqual(actualCategoryNames, expectedCategoryNames, "Category names do not match expected values")
    }
    
    func testProductInitialization() {
        let product = Product(
            id: "1",
            name: "Wireless Headphones",
            description: "Premium noise-cancelling headphones",
            price: 249.99,
            imageURL: "headphones",
            category: Category(id: "1", name: "Electronic", imageURL: ""),
            rating: 4.8,
            reviewCount: 423
        )
        
        XCTAssertEqual(product.id, "1")
        XCTAssertEqual(product.name, "Wireless Headphones")
        XCTAssertEqual(product.price, 249.99)
        XCTAssertEqual(product.rating, 4.8)
        XCTAssertEqual(product.reviewCount, 423)
    }
    
    func testProductEquality() {
        let product1 = Product(
            id: "1",
            name: "Item A",
            description: "Desc",
            price: 10.0,
            imageURL: "image",
            category: Category(id: "1", name: "Cate", imageURL: ""),
            rating: 4.5,
            reviewCount: 100
        )
        let product2 = Product(
            id: "1",
            name: "Item A",
            description: "Desc",
            price: 10.0,
            imageURL: "image",
            category: Category(id: "1", name: "Cate", imageURL: ""),
            rating: 4.5,
            reviewCount: 100
        )
        let product3 = Product(
            id: "2",
            name: "Item B",
            description: "Desc",
            price: 15.0,
            imageURL: "image",
            category: Category(id: "1", name: "Cate", imageURL: ""),
            rating: 4.0,
            reviewCount: 50
        )
        
        XCTAssertEqual(product1, product2) // Same id
        XCTAssertNotEqual(product1, product3) // Different id
    }
    
    func testProductHashing() {
        let product1 = Product(
            id: "1",
            name: "Item A",
            description: "Desc",
            price: 10.0,
            imageURL: "image",
            category: Category(id: "1", name: "Cate", imageURL: ""),
            rating: 4.5,
            reviewCount: 100
        )
        let product2 = Product(
            id: "1",
            name: "Item A",
            description: "Desc",
            price: 10.0,
            imageURL: "image",
            category: Category(id: "1", name: "Cate", imageURL: ""),
            rating: 4.5,
            reviewCount: 100
        )
        let productSet: Set<Product> = [product1, product2]
        
        XCTAssertEqual(productSet.count, 1, "Since product1 and product2 have the same id, only one should be stored in the set")
    }
}
