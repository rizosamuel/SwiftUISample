//
//  FeaturedProductsView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

import SwiftUI

struct FeaturedProductsView: View {
    
    @StateObject private var viewModel: FeaturedProductsViewModel
    
    init(viewModel: FeaturedProductsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(viewModel.featuredProducts) { product in
                    ProductCardView(product: product)
                }
            }
        }
        .navigationTitle("Featured Products")
        .accessibilityIdentifier("FeaturedProductsView")
    }
}

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

#Preview {
    FeaturedProductsView(viewModel: FeaturedProductsViewModel())
}
