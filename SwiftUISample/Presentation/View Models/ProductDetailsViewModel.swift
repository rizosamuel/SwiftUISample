//
//  ProductDetailsViewModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import Foundation

class ProductDetailsViewModel: ObservableObject {
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
}
