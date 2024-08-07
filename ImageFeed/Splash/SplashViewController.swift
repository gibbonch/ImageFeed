//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 07.08.2024.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let storage = OAuth2TokenStorage()
    private let authFlowSegueIdentifier = "AuthFlowSegue"

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if storage.token != nil {
            switchToTabBarController()
        } else {
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
                print("Fail to handle segue. Expected a UINavigationController containing an AuthViewController")
                return
            }
            authViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        
        let rootViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = rootViewController
    }

}

extension SplashViewController: AuthViewControllerDelegate {
    
    func didAuthentificate(_ viewController: AuthViewController) {
        viewController.dismiss(animated: true)
        switchToTabBarController()
    }
    
}
