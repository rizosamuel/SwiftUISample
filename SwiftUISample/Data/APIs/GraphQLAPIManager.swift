//
//  GraphQLAPIManager.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 18/03/25.
//

import Foundation
import Apollo
import ApolloAPI

class GraphQLManager {
    
    private let url: URL
    private let apolloClient: ApolloClient
    
    init(urlString: String = "https://your-graphql-endpoint.com/graphql") {
        self.url = URL(string: urlString)!
        self.apolloClient = ApolloClient(url: url)
    }
    
    func fetchGraphQLData<T: GraphQLQuery>(query: T, completion: @escaping (Result<T.Data, Error>) -> Void) {
        apolloClient.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                if let data = graphQLResult.data {
                    completion(.success(data))
                } else if let errors = graphQLResult.errors {
                    completion(.failure(errors.first ?? NSError(domain: "GraphQL Error", code: -1, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchGraphQLData<T: GraphQLQuery>(query: T) async throws -> T.Data {
        return try await withCheckedThrowingContinuation { continuation in
            fetchGraphQLData(query: query) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
