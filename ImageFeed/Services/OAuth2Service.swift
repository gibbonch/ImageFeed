//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Александр Торопов on 04.08.2024.
//

import Foundation

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    
    private init() { }
    
    func fetchOAuthToken(with code: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = makeBearerTokenRequest(with: code) else {
            return
        }
        
        URLSession.shared.fetchData(for: request, completion: completion)
    }
    
    private func makeBearerTokenRequest(with code: String) -> URLRequest? {
        var urlComponents = URLComponents(string: Constants.unsplashBearerTokenURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        return request
    }
    
}
