//
//  APIService.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 18/03/25.
//

enum APIType {
    case rest(model: RestModel)
    case graphql(model: GraphQLModel)
}

protocol APIService {
    func fetchData<T: Decodable>(using apiType: APIType, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func fetchData<T: Decodable>(using apiType: APIType, type: T.Type) async throws -> T
}
