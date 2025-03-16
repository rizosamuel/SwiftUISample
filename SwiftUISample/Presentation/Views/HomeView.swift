//
//  HomeView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var router: RouterImpl
    @StateObject private var viewModel: HomeViewModel
    @State private var searchText = ""
    @State private var isChatViewActive = false
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                // Search bar
                searchSection
                // Featured products carousel
                featuredProductsSection
                // Categories section
                categoriesSection
                // New arrivals section
                newArrivalsSection
                // Special offers section
                specialOffersSection
                // Recommended section based on browsing history
                recommendedSection
            }
            .padding()
        }
        .accessibilityIdentifier("HomeView")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                // Custom Profile View for navigation bar
                profileView
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                // Navigation Bar buttons
                NavIcons()
            }
        }
    }
    
    private var profileView: some View {
        Button(action: { router.navigate(to: .account, switchTab: true) }) {
            HStack(spacing: 8) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("Hello,")
                        .font(.caption)
                    Text("User")
                        .font(.callout)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    private var searchSection: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }
    
    private var featuredProductsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "Featured Products", actionLabel: "See All")
                .onTapGesture {
                    // Navigate to all featured products
                    router.navigate(to: .featuredProducts, switchTab: false)
                }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.featuredProducts) { product in
                        productCard(product)
                            .onTapGesture {
                                router.navigate(to: .product(product), switchTab: false)
                            }
                    }
                }
            }
        }
    }
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "Shop by Category", actionLabel: "All Categories")
                .onTapGesture {
                    router.navigate(to: .categories, switchTab: true)
                }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.categories) { category in
                        categoryCard(category)
                            .onTapGesture {
                                router.navigate(to: .category(category), switchTab: false)
                            }
                    }
                }
            }
        }
    }
    
    private var newArrivalsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "New Arrivals", actionLabel: "View More")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    // Similar to featured products but with different products
                    // Using the same products for demo purposes
                    ForEach(viewModel.featuredProducts.prefix(2)) { product in
                        productCard(product)
                            .onTapGesture {
                                router.navigate(to: .product(product), switchTab: false)
                            }
                    }
                }
            }
        }
    }
    
    private var specialOffersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "Special Offers", actionLabel: "See All")
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("WEEKEND SALE")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        
                        Text("20% OFF")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("On all electronics")
                            .font(.subheadline)
                        
                        Button(action: {
                            // Navigate to electronics category
                            if let electronicsCategory = viewModel.categories.first(where: { $0.name == "Electronics" }) {
                                router.navigate(to: .category(electronicsCategory), switchTab: true)
                            }
                        }) {
                            Text("Shop Now")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                    }
                    
                    Spacer()
                    
                    // This would be an image in a real app
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 80, height: 80)
                }
                .padding()
            }
            .frame(height: 160)
        }
    }
    
    private var recommendedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "Recommended for You", actionLabel: "View All")
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                ForEach(viewModel.featuredProducts) { product in
                    smallProductCard(product)
                        .onTapGesture {
                            router.navigate(to: .product(product), switchTab: false)
                        }
                }
            }
        }
    }
    
    private func sectionHeader(title: String, actionLabel: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Text(actionLabel)
                .font(.caption)
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
