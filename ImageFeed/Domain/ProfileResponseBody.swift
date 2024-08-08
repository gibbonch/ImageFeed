//
//  Profile.swift
//  ImageFeed
//
//  Created by Александр Торопов on 23.07.2024.
//

import Foundation

struct ProfileResponseBody {
    let avatarImageName: String
    let name: String
    let loginName: String
    let description: String?
    
    init(avatarImageName: String, name: String, loginName: String, description: String? = nil) {
        self.avatarImageName = avatarImageName
        self.name = name
        self.loginName = loginName
        self.description = description
    }
}
