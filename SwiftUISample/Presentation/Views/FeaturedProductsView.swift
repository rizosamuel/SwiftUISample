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
    
    private let columns: [GridItem] = [
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

#Preview {
    FeaturedProductsView(viewModel: FeaturedProductsViewModel())
}
