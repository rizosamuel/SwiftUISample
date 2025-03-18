//
//  APIService.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 18/03/25.
//

import ApolloAPI

enum APIType {
    case rest(endpoint: String)
    case graphql(query: any GraphQLQuery)
}

protocol APIService {
    func fetchData<T: Decodable>(apiType: APIType, completion: @escaping (Result<T, Error>) -> Void)
    func fetchData<T: Decodable>(apiType: APIType) async throws -> T
}
