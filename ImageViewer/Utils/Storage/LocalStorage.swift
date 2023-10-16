//
//  LocalStorage.swift
//  ImageViewer
//
//  Created by César Cubillos on 13/10/23.
//

import Foundation

/// Class manager to save data in UserDefaults
class LocalStorage {
    static let shared = LocalStorage()
    let defaults = UserDefaults.standard
    
    /// Save data in UserDefaults
    /// - Parameters:
    ///   - id: Identifier to save data in UserDefaults
    ///   - object: Data to save
    func save(in id: KeyStorage, with suffix: String?, object: Data) {
        defaults.set(object, forKey: id.rawValue + "-" + (suffix ?? ""))
    }
    
    /// Save array codable in UserDefaults
    /// - Parameters:
    ///   - id: Identifier to save data in UserDefaults
    ///   - codable: Array codable to save
    @discardableResult
    func save<T: Codable>(in id: KeyStorage, with suffix: String? = nil, object: T) -> Bool {
        do {
            let encoder = JSONEncoder()
            let dataEncoded = try encoder.encode(object)
            self.save(in: id, with: suffix, object: dataEncoded)
            return true
        } catch {
            return false
        }
    }
    
    /// Get data from UserDefaults
    /// - Parameter id: Identifier to load data from UserDefaults
    /// - Returns: An object Data with data saved
    func load(from id: KeyStorage, with suffix: String?) -> Data? {
        let savedData = defaults.object(forKey: id.rawValue + "-" + (suffix ?? ""))
        guard let object = savedData as? Data else {
            return nil
        }
        return object
    }
    
    /// Get data from UserDefaults
    /// - Parameter id: Identifier to load data from UserDefaults
    /// - Returns: An object Data with data saved
    func load<T: Codable>(_ t: T.Type, from id: KeyStorage, with suffix: String? = nil) -> T? {
        let decoder = JSONDecoder()
        guard let savedData = self.load(from: id, with: suffix),
              let object = try? decoder.decode(T.self, from: savedData) else {
            return nil
        }
        return object
    }
    
    func delete(from id: KeyStorage, with suffix: String? = nil) {
        defaults.removeObject(forKey: id.rawValue + "-" + (suffix ?? ""))
    }
}
