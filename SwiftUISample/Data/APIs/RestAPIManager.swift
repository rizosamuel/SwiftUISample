//
//  RestAPIManager.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 18/03/25.
//

import Foundation

class RestAPIManager {
    static let shared = RestAPIManager()
    private init() {}
}

extension RestAPIManager: APIService {
    
    func fetchData<T: Decodable>(apiType: APIType, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard case let .rest(endpoint) = apiType else {
            completion(.failure(NSError(domain: "Invalid Endpoint", code: -1, userInfo: nil)))
            return
        }
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchData<T: Decodable>(apiType: APIType) async throws -> T {
        
        guard case let .rest(endpoint) = apiType else {
            throw NSError(domain: "Invalid Endpoint", code: -1, userInfo: nil)
        }
        
        guard let url = URL(string: endpoint) else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
