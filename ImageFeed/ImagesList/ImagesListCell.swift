//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Торопов on 10.05.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ImagesListCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        guard let buttonImage = likeButton.imageView?.image else {
            return
        }
        
        let isLiked = buttonImage == UIImage.activeLike
        if isLiked {
            likeButton.setImage(UIImage.nonActiveLike, for: .normal)
        } else {
            likeButton.setImage(UIImage.activeLike, for: .normal)
        }
    }
    
}
