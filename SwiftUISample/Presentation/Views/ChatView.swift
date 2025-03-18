//
//  ChatView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject private var viewModel: ChatViewModel
    @State private var messageText = ""
    
    init(viewModel: ChatViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { scrollView in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(viewModel.messages) { message in
                                HStack {
                                    if message.isReceived {
                                        Text(message.text)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(12)
                                            .frame(maxWidth: 250, alignment: .leading)
                                        Spacer()
                                    } else {
                                        Spacer()
                                        Text(message.text)
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(12)
                                            .frame(maxWidth: 250, alignment: .trailing)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .onChange(of: viewModel.messages.count) {
                        withAnimation {
                            scrollView.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                
                HStack {
                    TextField("Type a message...", text: $messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        guard !messageText.isEmpty else { return }
                        viewModel.sendMessage(messageText)
                        messageText = ""
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Chat")
        }
        .accessibilityIdentifier("ChatView")
    }
}
