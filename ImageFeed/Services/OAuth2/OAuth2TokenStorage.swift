//
//  OAuth2TokenStorag.swift
//  ImageFeed
//
//  Created by Александр Торопов on 05.08.2024.
//

import Foundation

final class OAuth2TokenStorage {
    
    private let tokenKey = "bearer_token"
    private let semaphore = DispatchSemaphore(value: 1)
    
    var token: String? {
        get {
            semaphore.wait()
            defer {
                semaphore.signal()
            }
            
            let defaults = UserDefaults.standard
            let token = defaults.string(forKey: tokenKey)
            return token
        }
        set {
            semaphore.wait()
            defer {
                semaphore.signal()
            }
            
            let defaults = UserDefaults.standard
            defaults.setValue(newValue, forKey: tokenKey)
        }
    }
    
}
