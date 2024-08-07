//
//  URLSession+data.swift
//  ImageFeed
//
//  Created by Александр Торопов on 05.08.2024.
//

import UIKit

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    
    var localizedDescription: String {
        switch self {
        case .httpStatusCode(let code):
            return NSLocalizedString("HTTP status code error: \(code)", comment: "NetworkError - HTTP status code")
        case .urlRequestError(let error):
            return NSLocalizedString("URL request error: \(error.localizedDescription)", comment: "NetworkError - URL request")
        case .urlSessionError:
            return NSLocalizedString("URL session error occurred", comment: "NetworkError - URL session")
        }
    }
}

extension URLSession {
    
    func fetchData(for request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let performCompletion: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let task = dataTask(with: request, completionHandler: { data, response, error in
            if let data, let response, let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if 200 ..< 300 ~= statusCode {
                    performCompletion(.success(data))
                } else {
                    performCompletion(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error {
                performCompletion(.failure(NetworkError.urlRequestError(error)))
            } else {
                performCompletion(.failure(NetworkError.urlSessionError))
            }
        })
        
        task.resume()
    }
    
}
