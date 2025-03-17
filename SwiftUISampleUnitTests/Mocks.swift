//
//  Mocks.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import LocalAuthentication
@testable import SwiftUISample

class MockLAContext: LAContext {
    var canEvaluatePolicyReturnValue: Bool = true
    var biometryTypeOverride: LABiometryType = .none
    var evaluatePolicyResult: Bool = false
    var evaluatePolicyError: NSError?

    override var biometryType: LABiometryType {
        return biometryTypeOverride
    }

    override func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool {
        if !canEvaluatePolicyReturnValue {
            error?.pointee = NSError(domain: LAErrorDomain, code: LAError.biometryNotAvailable.rawValue, userInfo: nil)
        }
        return canEvaluatePolicyReturnValue
    }

    override func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
        reply(evaluatePolicyResult, evaluatePolicyError)
    }
}

class MockBiometricsRepository: BiometricsRepository {
    
    var shouldSucceed: Bool = true
    var isBiometricsAvailable: Bool = false
    var biometryErrorReason: String = ""
    
    func authenticate(completion: @escaping (Bool, String) -> Void) {
        completion(shouldSucceed, biometryErrorReason)
    }
}

class MockUserDefaultsRepository: UserDefaultsRepositoryImpl {
    
    private var storage: [String: Any] = [:]

    override func get<T>(forKey key: String, type: T.Type) -> T? where T: Decodable {
        return storage[key] as? T
    }

    override func save<T>(_ value: T, forKey key: String) where T: Encodable {
        storage[key] = value
    }
}
