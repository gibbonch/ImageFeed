//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Торопов on 10.07.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let cellIdentifier = "ImagesListCell"
    
    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    
    private let gradientLayer = CAGradientLayer()
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = gradientView.bounds
    
        let colors = [UIColor.clear,
                      UIColor(rgb: 0x1A1B22).withAlphaComponent(0.2)]
        let locations = [0.0, 1.0]
        
        gradientView.addGradient(with: gradientLayer, colors: colors, locations: locations)
    }
    
    @IBAction private func likeButtonDidTap(_ sender: Any) { }
}

extension UIView {
    func addGradient(with layer: CAGradientLayer, colors: [UIColor], locations: [Double]) {
        layer.frame = bounds
        layer.frame.origin = .zero
        
        let layerColors = colors.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }
        
        layer.colors = layerColors
        layer.locations = layerLocations
        
        self.layer.insertSublayer(layer, above: self.layer)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
