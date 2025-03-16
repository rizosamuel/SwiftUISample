//
//  UserDefaultsRepository.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import Foundation

protocol UserDefaultsRepository {
    func save<T: Codable>(_ value: T, forKey key: String)
    func get<T: Codable>(forKey key: String, type: T.Type) -> T?
    func delete(forKey key: String)
    func clearAll(userDefaultsName: String?)
}

class UserDefaultsRepositoryImpl: UserDefaultsRepository {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func save<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Failed to encode value for key \(key): \(error)")
        }
    }

    func get<T: Codable>(forKey key: String, type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Failed to decode value for key \(key): \(error)")
            return nil
        }
    }

    func delete(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func clearAll(userDefaultsName: String? = nil) {
        guard let bundleId = Bundle.main.bundleIdentifier else { return }
        let name = userDefaultsName ?? bundleId
        userDefaults.removePersistentDomain(forName: name)
    }
}
