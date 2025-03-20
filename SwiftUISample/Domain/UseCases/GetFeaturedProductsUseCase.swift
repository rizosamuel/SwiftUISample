//
//  GetFeaturedProductsUseCase.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 20/03/25.
//

protocol FeaturedProductsUseCase {
    func getFeaturedProducts(completion: @escaping (Result<[Product], any Error>) -> Void)
}

class FeaturedProductsUseCaseImpl: FeaturedProductsUseCase {
    
    private let apiService: APIService
    
    init(apiService: APIService = RestAPIManager.shared) {
        self.apiService = apiService
    }
    
    func getFeaturedProducts(completion: @escaping (Result<[Product], any Error>) -> Void) {
        
        let restModel = RestModel(
            endpoint: "/Products",
            httpMethod: .GET,
            headers: nil,
            body: nil
        )
        
        apiService.fetchData(using: .rest(model: restModel), type: [Product].self) { result in
            completion(result)
        }
    }
}
