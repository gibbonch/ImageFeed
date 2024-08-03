//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 01.08.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackwardButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebViewSegue" {
            guard let webViewViewController = segue.destination as? WebViewViewController else {
                return
            }
            
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
        navigationController?.popViewController(animated: true)
    }
    
    func webViewViewControllerDidCancel(_ viewController: WebViewViewController) { }
    
}
