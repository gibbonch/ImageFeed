//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 01.08.2024.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func didAuthentificate(_ viewController: AuthViewController)
}

final class AuthViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var indicatorBackgroundView: UIView!
    
    // MARK: - AuthViewControllerDelegate
    
    weak var delegate: AuthViewControllerDelegate?
    
    // MARK: - Services
    
    private let oauthService = OAuth2Service.shared
    private let oauthTokenStorage = OAuth2TokenStorage()
    
    // MARK: - StatusBar Appearance
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackwardButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebViewSegue" {
            guard let webViewViewController = segue.destination as? WebViewViewController else {
                print("Fail to handle segue. Expected a WebViewViewController")
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
    
    private func showActivityIndicator() {
        activityIndicatorView.isHidden = false
        indicatorBackgroundView.isHidden = false
        logoImageView.alpha = 0.75
        loginButton.alpha = 0.75
        loginButton.isEnabled = false
    }
    
}

// MARK: - WebViewViewControllerDelegate

extension AuthViewController: WebViewViewControllerDelegate {
    
    func webViewViewController(_ viewController: WebViewViewController, didAuthenticateWith code: String) {
        let fetchTokenCompletion: (Result<Data, Error>) -> Void = { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let token = try decoder.decode(OAuthTokenResponseBody.self, from: data).accessToken
                    
                    print("Bearer token recieved")
                    self.oauthTokenStorage.token = token
                    self.delegate?.didAuthentificate(self)
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print(error.localizedDescription)
                
                let alert = UIAlertController(
                    title: "Что-то пошло не так(",
                    message: "Не удалось войти в систему",
                    preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
        
        DispatchQueue.global().async { [weak self] in
            self?.oauthService.fetchAuthToken(with: code, completion: fetchTokenCompletion)
        }
        showActivityIndicator()
        navigationController?.popViewController(animated: true)
    }
    
}
