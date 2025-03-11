//
//  CategoriesViewModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        let categories = [
            Category(id: "1", name: "Electronics", imageURL: "electronics"),
            Category(id: "2", name: "Clothing", imageURL: "clothing"),
            Category(id: "3", name: "Home & Kitchen", imageURL: "home"),
            Category(id: "4", name: "Beauty", imageURL: "beauty"),
            Category(id: "5", name: "Sports & Outdoors", imageURL: "sports"),
            Category(id: "6", name: "Books & Stationery", imageURL: "books"),
            Category(id: "7", name: "Toys & Games", imageURL: "toys"),
            Category(id: "8", name: "Grocery & Essentials", imageURL: "grocery"),
            Category(id: "9", name: "Automotive", imageURL: "automotive"),
            Category(id: "10", name: "Health & Wellness", imageURL: "health"),
            Category(id: "11", name: "Jewelry & Accessories", imageURL: "jewelry"),
            Category(id: "12", name: "Furniture & Decor", imageURL: "furniture"),
            Category(id: "13", name: "Pet Supplies", imageURL: "pets"),
            Category(id: "14", name: "Office Supplies", imageURL: "office"),
            Category(id: "15", name: "Music & Instruments", imageURL: "music")
        ]

        self.categories = categories
    }
}
