//
//  ShareableImage.swift
//  ImageFeed
//
//  Created by Александр Торопов on 22.07.2024.
//

import UIKit
import LinkPresentation

final class ShareableImage: NSObject, UIActivityItemSource {
    
    private let image: UIImage
    private let title: String
    
    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
        
        super.init()
    }
    
    // MARK: - UIActivityItemSource
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return title
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return image
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.iconProvider = NSItemProvider(object: image)
        metadata.title = title
        return metadata
    }
    
}
