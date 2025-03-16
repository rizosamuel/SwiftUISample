//
//  Category.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

struct Category: Identifiable, Hashable {
    
    let id: String
    let name: String
    let imageURL: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}
