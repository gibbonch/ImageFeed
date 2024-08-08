//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 07.08.2024.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Strorage Service
    
    private let storage = OAuth2TokenStorage()
    
    // MARK: - Segue Identifier
    
    private let authFlowSegueIdentifier = "AuthFlowSegue"
    
    // MARK: - Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if storage.token != nil {
            Logger.debug("Authentication token detected in UserDefaults")
            switchToTabBarController()
        } else {
            Logger.debug("Authentication token was not detected in UserDefaults")
            
            Logger.debug("Perform authentication app flow")
            self.performSegue(withIdentifier: authFlowSegueIdentifier, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == authFlowSegueIdentifier {
            guard 
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers.first,
                let authViewController = viewController as? AuthViewController
            else {
                Logger.error("Fail to handle segue")
                return
            }
            authViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Performing the Main Application Flow
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            Logger.error("Invalid window configuration")
            return
        }
        
        Logger.debug("Perform main app flow")
        
        let rootViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = rootViewController
    }

}

// MARK: - AuthViewControllerDelegate

extension SplashViewController: AuthViewControllerDelegate {
    
    func didAuthentificate(_ viewController: AuthViewController) {
        switchToTabBarController()
    }
    
}
