//
//  CategoriesView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct CategoriesView: View {
    
    @EnvironmentObject private var router: RouterImpl
    @StateObject private var viewModel: CategoriesViewModel
    
    init(viewModel: CategoriesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                // Featured categories carousel
                featuredCategoriesSection
                // All categories grid
                allCategoriesSection
                // Special offers section
                specialOffersSection
            }
            .padding()
        }
        .navigationTitle("Categories")
        .accessibilityIdentifier("CategoriesView")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavIcons()
            }
        }
    }
    
    private var featuredCategoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "Featured".localized)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.categories.prefix(5), id: \.self) { category in
                        categoryCard(category)
                            .onTapGesture {
                                router.navigate(to: .category(category), switchTab: false)
                            }
                    }
                }
            }
        }
    }
    
    private var allCategoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "All Categories".localized)
            
            let rows = [GridItem(.flexible()), GridItem(.flexible())] // Two rows
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 15) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        categoryCardSquare(category)
                            .onTapGesture {
                                router.navigate(to: .category(category), switchTab: false)
                            }
                    }
                }
            }
        }
    }
    
    private var specialOffersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                sectionHeader(title: "Special Offers".localized)
                Spacer()
                Text("See All")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("LIMITED TIME DEAL")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        
                        Text("Up to 50% OFF")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("On selected categories")
                            .font(.subheadline)
                        
                        Button(action: {
                            // router.navigate(to: .categories, switchTab: true)
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
                    
                    // Placeholder for an image
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 80, height: 80)
                }
                .padding()
            }
            .frame(height: 160)
        }
    }
    
    private func sectionHeader(title: String) -> some View {
        Text(title)
            .font(.headline)
            .fontWeight(.bold)
    }
    
    private func categoryCard(_ category: String) -> some View {
        VStack {
            Image(systemName: "square.grid.2x2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
            
            Text(category)
                .font(.caption)
                .fontWeight(.bold)
        }
        .padding()
        .frame(width: 100, height: 120)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

#Preview {
    CategoriesView(viewModel: CategoriesViewModel())
}
