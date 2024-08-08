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
    
    // MARK: - Segue Identifier
    
    private let webViewSegueIdentifier = "WebViewSegue"
    
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
        if segue.identifier == webViewSegueIdentifier {
            guard let webViewViewController = segue.destination as? WebViewViewController else {
                Logger.error("Fail to handle segue. Expected a WebViewViewController")
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
    
    private func hideActivityIndicator() {
        activityIndicatorView.isHidden = true
        indicatorBackgroundView.isHidden = true
        logoImageView.alpha = 1.0
        loginButton.alpha = 1.0
        loginButton.isEnabled = true
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
                    
                    Logger.debug("Authentication token has been received")
                    
                    self.oauthTokenStorage.token = token
                    self.delegate?.didAuthentificate(self)
                } catch {
                    Logger.error("\(error.localizedDescription)")
                    self.showErrorAlert()
                }
            case .failure(let error):
                if let networkError = error as? NetworkError {
                    Logger.error(networkError.localizedDescription)
                }
                
                self.showErrorAlert()
            }
        }
        
        DispatchQueue.global().async { [weak self] in
            self?.oauthService.fetchAuthToken(with: code, completion: fetchTokenCompletion)
        }
        showActivityIndicator()
        navigationController?.popViewController(animated: true)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(
            title: "Что-то пошло не так(",
            message: "Не удалось войти в систему",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
            self.hideActivityIndicator()
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
}
