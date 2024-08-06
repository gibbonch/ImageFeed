//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 01.08.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - Services
    
    private let oauthService = OAuth2Service.shared
    private let oauthTokenStorage = OAuthTokenStorage.shared
    
    // MARK: - StatusBar Appearance
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackwardButton()
        
        if let _ = oauthTokenStorage.token {
            print("Bearer token was detected in UserDefaults")
        } else {
            print("Bearer token was not detected in UserDefaults")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebViewSegue" {
            guard let webViewViewController = segue.destination as? WebViewViewController else {
                return
            }
            
            webViewViewController.view.setNeedsLayout()
            webViewViewController.delegate = self
        }
    }
    
    // MARK: - UI Configuration
    
    private func configureBackwardButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "DarkBackward")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "DarkBackward")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .blackApp
    }
    
}

// MARK: - WebViewViewControllerDelegate

extension AuthViewController: WebViewViewControllerDelegate {
    
    func webViewViewController(_ viewController: WebViewViewController, didAuthenticateWith code: String) {
        
        let fetchTokenCompletion: (Result<Data, Error>) -> Void = {  [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let token = try decoder.decode(OAuthTokenResponseBody.self, from: data).accessToken
                    
                    print("Bearer token recieved")
                    self?.oauthTokenStorage.token = token
                    
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        DispatchQueue.global().async { [weak self] in
            self?.oauthService.fetchOAuthToken(with: code, completion: fetchTokenCompletion)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func webViewViewControllerDidCancel(_ viewController: WebViewViewController) { }
    
}
