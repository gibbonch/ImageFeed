//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 18.07.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var loginNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    @IBAction private func logoutButtonDidTap(_ sender: Any) { }
    
}
