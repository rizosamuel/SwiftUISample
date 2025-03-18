//
//  MultipeerManagerTests.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 17/03/25.
//

import XCTest
import MultipeerConnectivity
@testable import SwiftUISample

class MultipeerManagerTests: XCTestCase {
    
    var mockPeerID: MCPeerID!
    var mockSession: MockMCSession!
    var mockAdvertiser: MockAdvertiser!
    var mockBrowser: MockBrowser!
    var sut: MultipeerManager!
    
    override func setUp() {
        super.setUp()
        
        mockPeerID = MCPeerID(displayName: "TestPeer")
        mockSession = MockMCSession(peer: mockPeerID, securityIdentity: nil, encryptionPreference: .required)
        mockAdvertiser = MockAdvertiser(peer: mockPeerID, discoveryInfo: nil, serviceType: "test-service")
        mockBrowser = MockBrowser(peer: mockPeerID, serviceType: "test-service")
        
        sut = MultipeerManager(serviceType: "test-service", peerID: mockPeerID)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(sut.mcSession)
        XCTAssertNotNil(sut.advertiser)
        XCTAssertNotNil(sut.browser)
    }
    
    func testSendMessage() {
        let expectation = XCTestExpectation(description: "Sent message should be added to messages array")
        let messageText = "Hello, world!"
        sut.sendMessage(messageText)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            XCTAssertEqual(self?.sut.messages.count, 1)
            XCTAssertEqual(self?.sut.messages.first?.text, messageText)
            XCTAssertEqual(self?.sut.messages.first?.senderId, self?.mockPeerID.displayName)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testReceiveMessage() {
        let expectation = XCTestExpectation(description: "Received message should be added to messages array")
        let receivedMessage = Message(senderId: "TestSender", text: "Hello back!", isReceived: true)
        let mockSenderPeerID = MCPeerID(displayName: "TestSender")
        let receivedData = try! JSONEncoder().encode(receivedMessage)
        
        // Act: Manually invoke the delegate method
        sut.session(mockSession, didReceive: receivedData, fromPeer: mockSenderPeerID)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            XCTAssertEqual(self?.sut.messages.count, 1)
            XCTAssertEqual(self?.sut.messages.first?.text, receivedMessage.text)
            XCTAssertEqual(self?.sut.messages.first?.senderId, mockSenderPeerID.displayName)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testConnectionStateUpdates_toConnected() {
        let expectation = XCTestExpectation(description: "Connection state must update")
        let connectedPeer = MCPeerID(displayName: "TestPeer")
        mockSession.setConnectedPeers([connectedPeer])
        
        sut.session(mockSession, peer: connectedPeer, didChange: .connected)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let self = self {
                XCTAssertTrue(self.sut.isConnected)
            } else {
                XCTFail("Unexpectedly failed to retrieve self")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func testConnectionStateUpdates_toNotConnected() {
        let expectation = XCTestExpectation(description: "Connection state must update")
        sut.session(mockSession, peer: mockPeerID, didChange: .notConnected)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let self = self {
                XCTAssertFalse(self.sut.isConnected)
            } else {
                XCTFail("Unexpectedly failed to retrieve self")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
