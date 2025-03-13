//
//  CategoriesViewModelTests.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 13/03/25.
//

import XCTest
@testable import SwiftUISample

class CategoriesViewModelTests: XCTestCase {
    
    var sut: CategoriesViewModel!
    
    override func setUp() {
        super.setUp()
        sut = CategoriesViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_Categories_LoadedSuccessfully() {
        // Given: Expected category count
        let expectedCategoryCount = 15
        
        // When: The view model is initialized
        
        // Then: Ensure the categories array is populated
        XCTAssertEqual(sut.categories.count, expectedCategoryCount, "Expected \(expectedCategoryCount) categories, but got \(sut.categories.count)")
    }
    
    func test_Categories_ContainExpectedData() {
        // Given: Expected category names
        let expectedCategoryNames = ["Electronics", "Clothing", "Home & Kitchen", "Beauty"]
        
        // When: The view model is initialized
        let actualCategoryNames = sut.categories.map { $0.name }
        
        // Then: Ensure category names match expected values
        XCTAssertTrue(actualCategoryNames.contains(expectedCategoryNames), "Category names do not contain expected values")
    }
}
