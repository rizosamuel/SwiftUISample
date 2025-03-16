//
//  FeaturedProductsViewModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

import Foundation

class FeaturedProductsViewModel: ObservableObject {
    
    @Published var featuredProducts: [Product] = []
    
    init() {
        loadFeaturedProducts()
    }
    
    private func loadFeaturedProducts() {
        let sampleImages = [
            "https://via.placeholder.com/150/FF5733",
            "https://via.placeholder.com/150/33FF57",
            "https://via.placeholder.com/150/3357FF",
            "https://via.placeholder.com/150/FF33A1",
            "https://via.placeholder.com/150/A133FF"
        ]
        
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
        
        featuredProducts = (1...50).map { index in
            return Product(
                id: UUID().uuidString,
                name: "Product \(index)",
                description: "This is product \(index). High quality and best in class.",
                price: Double.random(in: 10...999),
                imageURL: sampleImages.randomElement()!,
                category: categories.randomElement()!,
                rating: Double.random(in: 3...5),
                reviewCount: Int.random(in: 50...1000)
            )
        }
    }
}
