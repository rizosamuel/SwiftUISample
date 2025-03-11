//
//  HomeView+Helpers.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

// MARK: - Helper methods
extension View {
    
    func productCard(_ product: Product) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product image (placeholder)
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Text(product.imageURL)
                        .font(.caption)
                        .foregroundColor(.gray)
                )
            
            // Product details
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(2)
            
            Text("$\(String(format: "%.2f", product.price))")
                .font(.subheadline)
                .fontWeight(.bold)
            
            // Rating
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption)
                
                Text(String(format: "%.1f", product.rating))
                    .font(.caption)
                
                Text("(\(product.reviewCount))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 160)
        .padding(.bottom, 8)
    }
    
    func smallProductCard(_ product: Product) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            // Product image (placeholder)
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Text(product.imageURL)
                        .font(.caption)
                        .foregroundColor(.gray)
                )
            
            // Product details
            Text(product.name)
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(1)
            
            Text("$\(String(format: "%.2f", product.price))")
                .font(.caption)
                .fontWeight(.bold)
        }
    }
    
    func categoryCard(_ category: Category) -> some View {
        VStack {
            // Category image (placeholder)
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 70, height: 70)
                .overlay(
                    Text(category.imageURL)
                        .font(.caption)
                        .foregroundColor(.gray)
                )
            
            Text(category.name)
                .font(.caption)
                .fontWeight(.medium)
        }
        .frame(width: 90)
    }
    
    func categoryCardSquare(_ category: Category) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product image (placeholder)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.2))
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Text(category.imageURL)
                        .font(.caption)
                        .foregroundColor(.gray)
                )
            
            // Product details
            Text(category.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(2)
        }
        .frame(width: 120)
        .padding(.bottom, 8)
    }
}

