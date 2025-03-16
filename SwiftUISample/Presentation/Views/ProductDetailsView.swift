//
//  ProductDetailsView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @StateObject private var viewModel: ProductDetailsViewModel
    
    init(viewModel: ProductDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Top Image covering top three edges
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2)) // Placeholder background color
                    .frame(height: UIScreen.main.bounds.width) // Makes it square
                    .edgesIgnoringSafeArea(.top) // Cover top edges
                
                AsyncImage(url: URL(string: viewModel.product.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            }
            
            // Product Details
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.product.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(viewModel.product.category.name)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                HStack {
                    Text("⭐ \(String(format: "%.1f", viewModel.product.rating)) (\(viewModel.product.reviewCount) reviews)")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                    
                    Spacer()
                    
                    Text("₹\(String(format: "%.2f", viewModel.product.price))")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Text(viewModel.product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                // Add to Cart Button
                Button(action: {
                    print("Added to cart")
                }) {
                    Text("Add to Cart")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview
struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView {
            ProductDetailsView(viewModel: getViewModel())
        }
    }
    
    static func getViewModel() -> ProductDetailsViewModel {
        let sampleCategory = Category(id: "1", name: "Electronics", imageURL: "electronics")
        let sampleProduct = Product(
            id: "123",
            name: "Smartphone",
            description: "A high-end smartphone with amazing features.",
            price: 69999.99,
            imageURL: "https://via.placeholder.com/300",
            category: sampleCategory,
            rating: 4.5,
            reviewCount: 256
        )
        return ProductDetailsViewModel(product: sampleProduct)
    }
}
