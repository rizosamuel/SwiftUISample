//
//  ChatViewModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    private let chatRepository: ChatRepository
    private var cancellables = Set<AnyCancellable>()

    @Published var messages: [Message] = []

    init(chatRepository: ChatRepository) {
        self.chatRepository = chatRepository

        // Observe the repository’s messages using Combine
        if let repo = chatRepository as? BonjourChatManager {
            repo.$messages
                .receive(on: DispatchQueue.main)
                .sink { [weak self] updatedMessages in
                    self?.messages = updatedMessages
                }
                .store(in: &cancellables)
        }
    }

    func sendMessage(_ text: String) {
        chatRepository.sendMessage(text)
    }
}
