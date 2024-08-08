//
//  AuthNavigationController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 05.08.2024.
//

import UIKit

final class AuthNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
}
