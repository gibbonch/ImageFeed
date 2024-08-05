//
//  MockImageLoader.swift
//  ImageFeed
//
//  Created by Александр Торопов on 14.07.2024.
//

import UIKit

struct MockImageLoader: ImageLoading {
    
    private let imageNames = Array(0..<20).map{ "\($0)" }
    
    func loadImages() -> [UIImage] {
        var images = [UIImage]()
        
        for imageName in imageNames {
            guard let image = UIImage(named: imageName) else {
                return [UIImage]()
            }
            
            images.append(image)
        }
        
        return images
    }
    
}
