//
//  BonjourChatManager.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 17/03/25.
//

import UIKit
import Network

class BonjourChatManager: NSObject, ObservableObject, ChatRepository {
    
    private let serviceType: String
    private let serviceName: String
    private let port: Int32
    private let serviceBrowser: NetServiceBrowser
    
    var netService: NetService?
    var inputStream: InputStream?
    var outputStream: OutputStream?
    var discoveredServices: [NetService] = []
    
    @Published var messages: [Message] = []
    @Published var isConnected: Bool = false
    
    init(
        serviceType: String = "_chatservice._tcp",
        serviceName: String = "\(UIDevice.current.name)-chat",
        port: Int32 = 12345, // Use a fixed port
        serviceBrowser: NetServiceBrowser = NetServiceBrowser()
    ) {
        self.serviceType = serviceType
        self.serviceName = serviceName
        self.port = port
        self.serviceBrowser = serviceBrowser
        self.netService = NetService(domain: "local.", type: serviceType, name: serviceName, port: port)
        super.init()
        
        startService()
        startBrowsing()
    }
    
    private func startService() {
        netService?.delegate = self
        netService?.publish(options: .listenForConnections)
    }
    
    private func startBrowsing() {
        serviceBrowser.delegate = self
        serviceBrowser.searchForServices(ofType: serviceType, inDomain: "local.")
    }
    
    func sendMessage(_ text: String) {
        guard let outputStream = outputStream else { return }
        let message = Message(senderId: serviceName, text: text, isReceived: false)
        
        DispatchQueue.main.async {
            self.messages.append(message)
        }
        
        if let data = try? JSONEncoder().encode(message) {
            _ = data.withUnsafeBytes { outputStream.write($0.bindMemory(to: UInt8.self).baseAddress!, maxLength: data.count) }
        }
    }
}

// MARK: - NetServiceDelegate
extension BonjourChatManager: NetServiceDelegate {
    func netService(_ sender: NetService, didAcceptConnectionWith inputStream: InputStream, outputStream: OutputStream) {
        print("Advertising Bonjour service: \(sender.name) on port \(sender.port)")
        self.inputStream = inputStream
        self.outputStream = outputStream
        self.isConnected = true
        
        inputStream.delegate = self
        inputStream.schedule(in: .main, forMode: .common)
        inputStream.open()
        outputStream.open()
    }
    
    func netServiceDidPublish(_ sender: NetService) {
        print("Service published on port: \(sender.port)")
    }
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        print("Resolved Bonjour service at \(sender.hostName ?? "unknown host")")
        
        var inputStream: InputStream?
        var outputStream: OutputStream?
        
        if sender.getInputStream(&inputStream, outputStream: &outputStream) {
            print("Successfully got input/output streams")
            self.inputStream = inputStream
            self.outputStream = outputStream
            self.isConnected = true
            
            inputStream?.delegate = self
            inputStream?.schedule(in: .main, forMode: .common)
            inputStream?.open()
            outputStream?.open()
        } else {
            print("Failed to retrieve streams")
        }
    }
}

// MARK: - NetServiceBrowserDelegate
extension BonjourChatManager: NetServiceBrowserDelegate {
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        print("Discovered Bonjour service: \(service.name)")
        discoveredServices.append(service)
        service.delegate = self
        service.resolve(withTimeout: 5.0)
    }
}

// MARK: - StreamDelegate
extension BonjourChatManager: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
            guard let inputStream = aStream as? InputStream else { return }
                
            var buffer = [UInt8](repeating: 0, count: 1024)
            let bytesRead = inputStream.read(&buffer, maxLength: buffer.count)
            
            guard bytesRead > 0 else { return }
            
            let receivedData = Data(buffer.prefix(bytesRead)) // Convert to Data
            
            do {
                var receivedMessage = try JSONDecoder().decode(Message.self, from: receivedData)
                receivedMessage.isReceived = true
                
                DispatchQueue.main.async {
                    self.messages.append(receivedMessage)
                }
            } catch {
                print("Error decoding message: \(error.localizedDescription)")
            }
        default:
            break
        }
    }
}
