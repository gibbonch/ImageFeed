//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 14.06.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var nicknameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    
    @IBAction private func logoutButtonDidTap(_ sender: Any) { }
    
}
