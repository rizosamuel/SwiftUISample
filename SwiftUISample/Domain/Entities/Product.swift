//
//  Product.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

struct Product: Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let category: String
    let rating: Double
    let reviewCount: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}
