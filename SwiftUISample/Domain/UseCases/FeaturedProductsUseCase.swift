//
//  GetFeaturedProductsUseCase.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 20/03/25.
//

import Foundation

protocol FeaturedProductsUseCase {
    func getFeaturedProducts(completion: @escaping (Result<[Product], any Error>) -> Void)
    func saveProduct(_ product: Product, completion: @escaping (Result<Product, any Error>) -> Void)
}

class FeaturedProductsUseCaseImpl: FeaturedProductsUseCase {
    
    private let apiService: APIService
    
    init(apiService: APIService = RestAPIManager.shared) {
        self.apiService = apiService
    }
    
    func getFeaturedProducts(completion: @escaping (Result<[Product], any Error>) -> Void) {
        
        let restModel = RestModel(
            endpoint: "/products",
            httpMethod: .GET,
            headers: nil,
            body: nil
        )
        
        apiService.fetchData(using: .rest(model: restModel), type: [Product].self) { result in
            completion(result)
        }
    }
    
    func saveProduct(_ product: Product, completion: @escaping (Result<Product, any Error>) -> Void) {
        
        let restModel = RestModel(
            endpoint: "/products",
            httpMethod: .POST,
            headers: nil,
            body: product.encode()
        )
        
        apiService.fetchData(using: .rest(model: restModel), type: Product.self) { result in
            completion(result)
        }
    }
}
