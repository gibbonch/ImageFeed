//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Торопов on 10.07.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    static let cellIdentifier = "ImagesListCell"
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var likeButton: UIButton!
    
    private let gradientLayer = CAGradientLayer()
    
    var isLiked = false {
        didSet {
            if isLiked {
                likeButton.setImage(.activeLike, for: .normal)
            } else {
                likeButton.setImage(.nonActiveLike, for: .normal)
            }
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = gradientView.bounds
    
        let colors = [UIColor(rgb: 0x1A1B22).withAlphaComponent(0.0),
                      UIColor(rgb: 0x1A1B22).withAlphaComponent(0.2)]
        let locations = [0.0, 1.0]
        
        gradientView.addGradient(with: gradientLayer, colors: colors, locations: locations)
    }
    
    @IBAction private func likeButtonDidTap(_ sender: Any) {
        isLiked.toggle()
    }
    
}
