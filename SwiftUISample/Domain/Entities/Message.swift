//
//  Message.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

import Foundation

struct Message: Identifiable, Codable {
    
    let id: UUID
    let senderId: String
    let text: String
    let isReceived: Bool

    init(id: UUID = UUID(), senderId: String, text: String, isReceived: Bool) {
        self.id = id
        self.senderId = senderId
        self.text = text
        self.isReceived = isReceived
    }
}
