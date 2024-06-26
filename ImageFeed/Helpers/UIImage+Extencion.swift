//
//  UIImage+Extencion.swift
//  ImageFeed
//
//  Created by Александр Торопов on 19.06.2024.
//

import UIKit

extension UIImage {
    
    var imageSize: String {
        guard let imageData = self.toData() else { return "Unknown size" }
        let size = Double(imageData.count)
        if size < 1024 {
            return String(format: "%.2f bytes", size)
        } else if size < 1024 * 1024 {
            return String(format: "%.2f KB", size/1024.0)
        } else {
            return String(format: "%.2f MB", size/(1024.0*1024.0))
        }
    }
    
    var imageType: String {
        guard let data = self.toData(), data.count > 8 else { return "unknown" }
        
        var header = [UInt8](repeating: 0, count: 8)
        data.copyBytes(to: &header, count: 8)
        
        switch header {
        case [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]:
            return "png"
        case [0xFF, 0xD8, 0xFF]:
            return "jpg"
        default:
            return "unknown"
        }
    }
    
    func toData() -> Data? {
        return self.pngData() ?? self.jpegData(compressionQuality: 1.0)
    }
    
}
