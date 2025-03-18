//
//  BonjourChatManagerTests.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 18/03/25.
//

import XCTest
@testable import SwiftUISample

class BonjourChatManagerTests: XCTestCase {
    
    var chatManager: BonjourChatManager!
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    override func setUp() {
        super.setUp()
        chatManager = BonjourChatManager()
        
        // Create a pair of streams (this simulates a real network connection)
        Stream.getBoundStreams(withBufferSize: 1024, inputStream: &inputStream, outputStream: &outputStream)
        
        // Set up input stream in chat manager
        chatManager.inputStream = inputStream
        chatManager.outputStream = outputStream
        chatManager.inputStream?.delegate = chatManager
    }
    
    override func tearDown() {
        chatManager = nil
        inputStream = nil
        outputStream = nil
        super.tearDown()
    }
    
    func test_SendMessage_AddsMessageToMessages() {
        let messageText = "Hello, Test!"
        let expectation = XCTestExpectation(description: "Sent message should be added to messages array")
        let initialMessageCount = chatManager.messages.count
        
        chatManager.sendMessage(messageText)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let self = self {
                XCTAssertEqual(chatManager.messages.count, initialMessageCount + 1, "Message was not added to messages array")
                guard let lastMessage = chatManager.messages.last else {
                    XCTFail("No message was added to messages array")
                    return
                }
                
                XCTAssertEqual(lastMessage.text, messageText, "Message text does not match")
                XCTAssertEqual(lastMessage.isReceived, false, "Message should be marked as sent (not received)")
            } else {
                XCTFail("Unexpectedly failed to retrieve self")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_SendMessage_WritesToOutputStream() {
        let message = Message(senderId: "Device1", text: "Hello!", isReceived: false)
        
        guard let outputStream = chatManager.outputStream else {
            XCTFail("Output stream is nil")
            return
        }
        
        outputStream.open()
        
        guard outputStream.streamStatus == .open else {
            XCTFail("Output stream is not open")
            return
        }
        
        guard let data = try? JSONEncoder().encode(message) else {
            XCTFail("Failed to encode message")
            return
        }
        
        XCTAssertGreaterThan(data.count, 0, "Encoded data should not be empty")
        
        let bytesWritten = data.withUnsafeBytes { buffer in
            guard let pointer = buffer.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                XCTFail("Failed to get pointer to data")
                return -1
            }
            return outputStream.write(pointer, maxLength: data.count)
        }
        
        XCTAssertNotEqual(bytesWritten, -1, "Writing to output stream failed")
        XCTAssertEqual(bytesWritten, data.count, "Failed to write all data to output stream")
    }
    
    func test_ReceiveMessage_AppendsToMessages() {
        let validUUID = UUID().uuidString
        let jsonMessage = """
            {
                "id": "\(validUUID)",
                "senderId": "Device1",
                "text": "Hello back!",
                "isReceived": false
            }
            """
        
        guard let messageData = jsonMessage.data(using: .utf8) else {
            XCTFail("Failed to encode test message")
            return
        }
        
        let mockInputStream = MockInputStream(data: messageData)
        chatManager.stream(mockInputStream, handle: .hasBytesAvailable)
        let expectation = XCTestExpectation(description: "Sent message should be added to messages array")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let self = self {
                XCTAssertEqual(self.chatManager.messages.count, 1)
                XCTAssertEqual(self.chatManager.messages.last?.text, "Hello back!")
                XCTAssertTrue(self.chatManager.messages.last?.isReceived ?? false)
            } else {
                XCTFail("Unexpectedly failed to retrieve self")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_NetworkConnection_UpdatesIsConnectedState() {
        XCTAssertFalse(chatManager.isConnected)
        
        // Simulate connection
        chatManager.netService(chatManager.netService!, didAcceptConnectionWith: inputStream, outputStream: outputStream)
        
        XCTAssertTrue(chatManager.isConnected, "isConnected should be true after accepting a connection")
    }
}
