//
//  KeyChanManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit
import Security

class KeyChainManager {
    
   // static let instance = KeyChainManager()
    init() { }
    
    ///Add value to keychain
    func save(value: String, for key: String) throws {
        if let data = value.data(using: .utf8) {
            let query: [String : Any] = [
                kSecClass as String : kSecClassGenericPassword,
                kSecAttrAccount as String : key,
                kSecValueData as String : data,
                kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlocked
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            guard status != errSecDuplicateItem else {
                throw KeychainError.duplicateEntry
            }
            
            guard status == errSecSuccess else {
                throw KeychainError.unknown(status)
            }
        }
    }
    
    ///Retreive value from keichain
    func get(for key: String) -> String? {
        
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String : true,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
        
        var value: CFTypeRef?
        
        let status = SecItemCopyMatching(query as CFDictionary, &value)
        
        if status == errSecSuccess, let data = value as? Data {
            return String(data: data, encoding: .utf8)
        }
        
       return nil
    }
    
    ///Delete value from keychain
    func delete(for key: String) {
        
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
