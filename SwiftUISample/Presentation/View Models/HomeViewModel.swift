//
//  HomeViewModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var featuredProducts: [Product] = []
    @Published var categories: [Category] = []
    
    init() {
        loadFeaturedProducts()
        loadCategories()
    }
    
    private func loadFeaturedProducts() {
        let products = [
            Product(
                id: "1",
                name: "Wireless Headphones",
                description: "Premium noise-cancelling headphones with 30-hour battery life",
                price: 249.99,
                imageURL: "headphones",
                category: Category(id: "1", name: "Electronics", imageURL: "electronics"),
                rating: 4.8,
                reviewCount: 423
            ),
            Product(
                id: "2",
                name: "Smart Watch",
                description: "Fitness and health tracking with heart rate monitor and GPS",
                price: 199.99,
                imageURL: "smartwatch",
                category: Category(id: "1", name: "Electronics", imageURL: "electronics"),
                rating: 4.6,
                reviewCount: 287
            ),
            Product(
                id: "3",
                name: "Portable Speaker",
                description: "Waterproof Bluetooth speaker with 360° sound",
                price: 129.99,
                imageURL: "speaker",
                category: Category(id: "1", name: "Electronics", imageURL: "electronics"),
                rating: 4.7,
                reviewCount: 156
            )
        ]
        
        featuredProducts = products
    }
    
    private func loadCategories() {
        let categories = [
            Category(id: "1", name: "Electronics", imageURL: "electronics"),
            Category(id: "2", name: "Clothing", imageURL: "clothing"),
            Category(id: "3", name: "Home & Kitchen", imageURL: "home"),
            Category(id: "4", name: "Beauty", imageURL: "beauty")
        ]
        self.categories = categories
    }
}
