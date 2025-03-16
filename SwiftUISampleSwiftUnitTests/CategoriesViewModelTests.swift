//
//  CategoriesViewModelTests.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

import Testing
@testable import SwiftUISample

@Suite
struct CategoriesViewModelTests {
    
    let sut = CategoriesViewModel() // Initialize ViewModel
    
    @Test func test_Categories_LoadedSuccessfully() {
        // Given: Expected category count
        let expectedCategoryCount = 15

        // Then: Ensure the categories array is populated
        #expect(sut.categories.count == expectedCategoryCount)
    }
    
    @Test func test_Categories_ContainExpectedData() {
        // Given: Expected category names
        let expectedCategoryNames = ["Electronics", "Clothing", "Home & Kitchen", "Beauty"]
        
        // When: Extract actual category names
        let actualCategoryNames = sut.categories.map { $0.name }
        
        // Then: Ensure category names match expected values
        #expect(expectedCategoryNames.allSatisfy(actualCategoryNames.contains))
    }
}
