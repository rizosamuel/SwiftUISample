//
//  MultipeerManager.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

import Foundation
import MultipeerConnectivity

class MultipeerManager: NSObject, ObservableObject, ChatRepository {
    
    private let serviceType = "chat-service"

    private var peerID: MCPeerID
    private var session: MCSession
    private var advertiser: MCNearbyServiceAdvertiser?
    private var browser: MCNearbyServiceBrowser?

    // protocol conformance
    @Published var messages: [Message] = []
    @Published var isConnected: Bool = false

    override init() {
        self.peerID = MCPeerID(displayName: UIDevice.current.name)
        self.session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)

        super.init()
        self.session.delegate = self

        self.advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        self.advertiser?.delegate = self
        self.advertiser?.startAdvertisingPeer()

        self.browser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        self.browser?.delegate = self
        self.browser?.startBrowsingForPeers()
    }

    func sendMessage(_ text: String) {
        let message = Message(senderId: peerID.displayName, text: text, isReceived: false)

        DispatchQueue.main.async {
            self.messages.append(message)
        }

        if let data = try? JSONEncoder().encode(message) {
            try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
    }

    private func receiveMessage(_ data: Data, from sender: MCPeerID) {
        if let receivedMessage = try? JSONDecoder().decode(Message.self, from: data) {
            let message = Message(senderId: sender.displayName, text: receivedMessage.text, isReceived: true)

            DispatchQueue.main.async {
                self.messages.append(message)
            }
        }
    }
}

// MARK: - MCSessionDelegate
extension MultipeerManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DispatchQueue.main.async {
            self.isConnected = !session.connectedPeers.isEmpty
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        receiveMessage(data, from: peerID)
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
}

// MARK: - MCNearbyServiceAdvertiserDelegate
extension MultipeerManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
}

// MARK: - MCNearbyServiceBrowserDelegate
extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {}
}
