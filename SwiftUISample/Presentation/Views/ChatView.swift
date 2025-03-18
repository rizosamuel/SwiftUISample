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
    
    struct MessageView: View {
        let message: Message

        var body: some View {
            HStack {
                if message.isReceived {
                    TextBubble(message.text, background: Color.gray.opacity(0.2))
                    Spacer()
                } else {
                    Spacer()
                    TextBubble(message.text, background: Color.blue, foreground: .white)
                }
            }
        }
    }

    struct TextBubble: View {
        let text: String
        let background: Color
        let foreground: Color?

        init(_ text: String, background: Color, foreground: Color? = nil) {
            self.text = text
            self.background = background
            self.foreground = foreground
        }

        var body: some View {
            Text(text)
                .padding()
                .background(background)
                .foregroundColor(foreground ?? .primary)
                .cornerRadius(12)
                .frame(maxWidth: 250, alignment: .leading)
        }
    }

    struct MessageInputView: View {
        @Binding var messageText: String
        let sendMessage: () -> Void

        var body: some View {
            HStack {
                TextField("Type a message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
        }
    }
}
