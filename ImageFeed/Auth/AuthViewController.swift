//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 01.08.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let oauthService = OAuth2Service.shared
    private let oauthTokenStorage = OAuthTokenStorage()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackwardButton()
        
        print("Bearer token: \(oauthTokenStorage.token ?? "no_token")")
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
    
    private func configureBackwardButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "DarkBackward")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "DarkBackward")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .blackApp
    }
    
}

extension AuthViewController: WebViewViewControllerDelegate {
    
    func webViewViewController(_ viewController: WebViewViewController, didAuthenticateWith code: String) {
        
        DispatchQueue.global().async { [weak self] in
            self?.oauthService.fetchOAuthToken(with: code) { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let token = try decoder.decode(BearerTokenResponseBody.self, from: data).accessToken
                        
                        print("Bearer token recieved")
                        self?.oauthTokenStorage.token = token
                        
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
            
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func webViewViewControllerDidCancel(_ viewController: WebViewViewController) { }
    
}
