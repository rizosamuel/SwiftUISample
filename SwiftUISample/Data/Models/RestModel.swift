//
//  RestModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 20/03/25.
//

import Foundation

enum RestHTTPMethod: String {
    case GET, POST, PUT, DELETE, PATCH
}

struct RestModel {
    let endpoint: String
    let httpMethod: RestHTTPMethod
    let headers: [String: String]?
    let body: Data?
}
