//
//  Constants.swift
//  ImageFeed
//
//  Created by Александр Торопов on 29.07.2024.
//

import Foundation

enum Constants {
    static let accessKey = "ImJf6av8ow7MhwckpYmbC3sA3jI3xWfc6rmAcEiWG9I"
    static let secretKey = "nzGo5qpiFreicVRFAFniyyk9c0-CcTKf_vY6ZQFkD2w"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defualtBaseURL = URL(string: "https://api.unsplash.com/")
    static let unsplashAuthorizeURL = "https://unsplash.com/oauth/authorize"
}
