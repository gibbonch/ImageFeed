//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 18.07.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let storage = OAuth2TokenStorage()
    
    // MARK: - UI Components
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 61
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(hex: 0xAEAFB4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(.exit, for: .normal)
        button.addTarget(nil, action: #selector(logoutButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mockModel = ProfileResponseBody(avatarImageName: "UserAvatar",
                                     name: "Екатерина Новикова",
                                     loginName: "@ekaterina_nov",
                                     description: "Hello, world!")
        configureUI(with: mockModel)
        
        configureView()
        setConstraints()
    }
    
    // MARK: - Logout Action
    
    @objc private func logoutButtonDidTap() {
        storage.token = nil
        
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        
        let rootViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SplashViewController")
        window.rootViewController = rootViewController
    }
    
    // MARK: - UI Configuration Methods
    
    private func configureView() {
        view.backgroundColor = .blackApp
        
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(loginNameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(logoutButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            loginNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
            
        ])
    }
    
    private func configureUI(with model: ProfileResponseBody) {
        avatarImageView.image = UIImage(named: model.avatarImageName)
        nameLabel.text = model.name
        loginNameLabel.text = model.loginName
        descriptionLabel.text = model.description
    }
    
}
