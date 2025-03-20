//
//  FeaturedProductsView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

import SwiftUI

struct FeaturedProductsView: View {
    
    @EnvironmentObject private var router: RouterImpl
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
                        .onTapGesture {
                            router.navigate(to: .product(product), switchTab: false)
                        }
                }
            }
        }
        .onAppear {
            viewModel.getFeaturedProducts()
        }
        .navigationTitle("Featured Products")
        .accessibilityIdentifier("FeaturedProductsView")
    }
}

#Preview {
    let useCase = FeaturedProductsUseCaseImpl()
    let viewModel = FeaturedProductsViewModel(useCase: useCase)
    FeaturedProductsView(viewModel: viewModel)
}
