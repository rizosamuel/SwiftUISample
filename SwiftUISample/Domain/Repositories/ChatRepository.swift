//
//  ChatRepository.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

protocol ChatRepository {
    var messages: [Message] { get }
    var isConnected: Bool { get }
    func sendMessage(_ text: String)
}
