//
//  KeyChanManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit
import Security


class KeyChanManager {
    
    static let instance = KeyChanManager()
    private init() { }
    
    enum KeyChanError: Error {
        case duplicateEntry, unknown(OSStatus)
    }
    
    func saveSession(value: String, for key: String) throws {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String : kSecClassGenericPassword,
                kSecAttrAccount as String : key,
                kSecValueData as String : data,
                kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlocked
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            guard status != errSecDuplicateItem else {
                throw KeyChanError.duplicateEntry
            }
            
            guard status == errSecSuccess else {
                throw KeyChanError.unknown(status)
            }
        }
    }
    
    func getSession(for key: String) -> String? {
        
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String : true,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    func deleteItem(for key: String) {
        
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key
        ]
        
        let result = SecItemDelete(query as CFDictionary)
        
        if result == errSecSuccess {
            print("Item deleted")
        } else {
            print("Error of deleting item from keychan")
        }
    }
}
