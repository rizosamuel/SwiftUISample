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

        let categories = ["Electronics", "Clothing", "Home & Kitchen", "Beauty", "Accessories"]

        featuredProducts = (1...50).map { index in
            Product(
                id: UUID().uuidString,
                name: "Product \(index)",
                description: "This is product \(index). High quality and best in class.",
                price: Double.random(in: 10...999),
                imageURL: sampleImages[index % sampleImages.count],
                category: categories[index % categories.count],
                rating: Double.random(in: 3...5),
                reviewCount: Int.random(in: 50...1000)
            )
        }
    }
}
