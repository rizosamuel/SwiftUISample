//
//  MultipeerManager.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 14/03/25.
//

import MultipeerConnectivity

class MultipeerManager: NSObject, ObservableObject, ChatRepository {
    
    private let serviceType: String
    private let peerID: MCPeerID
    
    let mcSession: MCSession
    let advertiser: MCNearbyServiceAdvertiser
    let browser: MCNearbyServiceBrowser

    // protocol conformance
    @Published var messages: [Message] = []
    @Published var isConnected: Bool = false

    init(
        serviceType: String = "chat-service",
        peerID: MCPeerID = MCPeerID(displayName: UIDevice.current.name)
    ) {
        self.serviceType = serviceType
        self.peerID = peerID
        self.mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        self.advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        self.browser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        super.init()
        
        self.mcSession.delegate = self
        
        self.advertiser.delegate = self
        self.advertiser.startAdvertisingPeer()

        self.browser.delegate = self
        self.browser.startBrowsingForPeers()
    }

    func sendMessage(_ text: String) {
        let message = Message(senderId: peerID.displayName, text: text, isReceived: false)

        DispatchQueue.main.async {
            self.messages.append(message)
        }

        if let data = try? JSONEncoder().encode(message) {
            try? mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
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
        invitationHandler(true, mcSession)
    }
}

// MARK: - MCNearbyServiceBrowserDelegate
extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: 10)
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {}
}
