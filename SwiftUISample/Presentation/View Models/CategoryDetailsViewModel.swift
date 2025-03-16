//
//  CategoryDetailsViewModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import Foundation

class CategoryDetailsViewModel: ObservableObject {
    
    private let category: Category
    var products: [Product] = []
    
    init(category: Category) {
        self.category = category
        loadProductsForCategory()
    }
    
    private func loadProductsForCategory() {
        let sampleImages = [
            "https://via.placeholder.com/150/FF5733",
            "https://via.placeholder.com/150/33FF57",
            "https://via.placeholder.com/150/3357FF",
            "https://via.placeholder.com/150/FF33A1",
            "https://via.placeholder.com/150/A133FF"
        ]
        
        products = (1...50).map { index in
            return Product(
                id: UUID().uuidString,
                name: "Product \(index)",
                description: "This is product \(index). High quality and best in class.",
                price: Double.random(in: 10...999),
                imageURL: sampleImages.randomElement()!,
                category: category,
                rating: Double.random(in: 3...5),
                reviewCount: Int.random(in: 50...1000)
            )
        }
    }
}
