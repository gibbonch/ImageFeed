//
//  UIView+Extension.swift
//  ImageFeed
//
//  Created by Александр Торопов on 10.07.2024.
//

import UIKit

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
