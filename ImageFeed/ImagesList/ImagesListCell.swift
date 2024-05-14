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
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.gradientYP.withAlphaComponent(0.2).cgColor
        ]
        
        gradientView.layer.addSublayer(gradientLayer)
    }
    
}
