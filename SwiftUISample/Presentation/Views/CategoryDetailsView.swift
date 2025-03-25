//
//  CategoryDetailsView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import SwiftUI

struct CategoryDetailsView: View {
    
    @EnvironmentObject private var router: RouterImpl
    @StateObject private var viewModel: CategoryDetailsViewModel
    
    init(viewModel: CategoryDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(viewModel.products) { product in
                    ProductCardView(product: product)
                        .onTapGesture {
                            router.navigate(to: .product(product), switchTab: false)
                        }
                }
            }
        }
        .navigationTitle("\(viewModel.products[0].category.name) Products")
        .accessibilityIdentifier("CategoryDetailsView")
    }
}

#Preview {
    let category = Category(id: "1", name: "Electronics", imageURL: "electronics")
    let viewModel = CategoryDetailsViewModel(category: category)
    CategoryDetailsView(viewModel: viewModel)
}
