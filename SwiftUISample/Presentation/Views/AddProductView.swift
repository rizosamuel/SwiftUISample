//
//  AddProductView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 21/03/25.
//

import SwiftUI

struct AddProductView: View {
    
    @EnvironmentObject private var router: RouterImpl
    @StateObject private var viewModel: AddProductViewModel
    
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var selectedCategory: Category?
    @State private var productImageURL = ""
    
    init(viewModel: AddProductViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Name", text: $productName)
                    TextField("Description", text: $productDescription)
                    TextField("Price", text: $productPrice)
                        .keyboardType(.decimalPad)
                    TextField("Image URL", text: $productImageURL)
                }
                
                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(viewModel.categories, id: \.id) { category in
                            Text(category.name).tag(category as Category?)
                        }
                    }
                }
                
                Button("Save Product") {
                    // saveProduct()
                    router.presentModal(.cart)
                }
                // .disabled(productName.isEmpty || productDescription.isEmpty || selectedCategory == nil || productPrice.isEmpty)
            }
            .navigationTitle("New Product")
            .navigationBarItems(trailing: Button("Cancel") {
                router.dismissModal()
            })
        }
    }
    
    private func saveProduct() {
        
        guard let category = selectedCategory,
              let price = Double(productPrice),
              !productName.isEmpty,
              !productDescription.isEmpty else { return }
        
        let newProduct = Product(
            id: UUID().uuidString,
            name: productName,
            description: productDescription,
            price: price,
            imageURL: productImageURL,
            category: category,
            rating: 0.0,
            reviewCount: 0
        )
        
        viewModel.saveProduct(newProduct)
    }
}

#Preview {
    let useCase = FeaturedProductsUseCaseImpl()
    let viewModel = AddProductViewModel(useCase: useCase)
    AddProductView(viewModel: viewModel)
}
