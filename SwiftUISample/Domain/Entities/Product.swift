//
//  Product.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import Foundation

struct Product: Identifiable, Hashable, Codable {
    
    let id: String
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let category: Category
    let rating: Double
    let reviewCount: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            print("❌ Encoding failed: \(error.localizedDescription)")
            return nil
        }
    }
}
