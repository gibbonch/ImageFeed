//
//  OAuthTokenStorage.swift
//  ImageFeed
//
//  Created by Александр Торопов on 05.08.2024.
//

import Foundation

final class OAuthTokenStorage {
    
    var token: String? {
        get {
            let defaults = UserDefaults.standard
            let token = defaults.string(forKey: tokenKey)
            return token
        }
        set {
            let defaults = UserDefaults.standard
            defaults.setValue(newValue, forKey: tokenKey)
        }
    }
    
    private let tokenKey = "bearer_token"
    
}
