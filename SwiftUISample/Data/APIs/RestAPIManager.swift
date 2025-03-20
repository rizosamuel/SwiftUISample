//
//  RestAPIManager.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 18/03/25.
//

import Foundation

class RestAPIManager {
    
    static let shared = RestAPIManager()
    private let baseUrl: String
    
    private init(
        baseUrl: String = "https://my-json-server.typicode.com/rizosamuel/MockServer"
    ) {
        self.baseUrl = baseUrl
    }
    
    private func getURLRequest(for model: RestModel) -> URLRequest? {
        
        guard let url = URL(string: baseUrl + model.endpoint) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = model.httpMethod.rawValue
        request.httpBody = model.body
        return request
    }
}

extension RestAPIManager: APIService {
    
    func fetchData<T: Decodable>(using apiType: APIType, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard case let .rest(model) = apiType else {
            completion(.failure(NSError(domain: "Invalid Endpoint", code: -1, userInfo: nil)))
            return
        }
        
        guard let urlRequest = getURLRequest(for: model) else {
            completion(.failure(NSError(domain: "Invalid Request", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
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
                print("Could not decode response \(error.localizedDescription)")
                print("The recieved data is \(data.printJSON())")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchData<T: Decodable>(using apiType: APIType, type: T.Type) async throws -> T {
        
        guard case let .rest(model) = apiType else {
            throw NSError(domain: "Invalid Endpoint", code: -1, userInfo: nil)
        }
        
        guard let urlRequest = getURLRequest(for: model) else {
            throw NSError(domain: "Invalid Request", code: -1, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
