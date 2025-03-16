//
//  FileIdentifier.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

protocol FileIdentifier {
    var fileName: String { get }
}

extension FileIdentifier {
    var fileName: String {
        String(describing: type(of: self))
    }
}
