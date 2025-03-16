//
//  ProductCardView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import SwiftUI

struct ProductCardView: View {
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Product Image
            AsyncImage(url: URL(string: product.imageURL)) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3) // Placeholder color
            }
            .frame(height: 150)
            .clipped()
            
            // Product Name & Price
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("$\(String(format: "%.2f", product.price))")
                    .font(.subheadline)
                    .foregroundColor(.green)
                
                // Rating & Reviews
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(product.rating, specifier: "%.1f") (\(product.reviewCount))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding(8)
        }
        .border(Color.gray.opacity(0.2), width: 1)
    }
}
