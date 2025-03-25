//
//  AddProductViewModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 21/03/25.
//

import Foundation

class AddProductViewModel: ObservableObject {
    
    private let useCase: FeaturedProductsUseCase
    @Published var categories: [Category] = []
    @Published var errorMessage: String = ""
    
    init(useCase: FeaturedProductsUseCase) {
        self.useCase = useCase
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
    
    func saveProduct(_ product: Product) {
        useCase.saveProduct(product) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let product):
                    print("saved product is \(product)")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
