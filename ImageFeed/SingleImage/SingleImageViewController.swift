//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 19.07.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImageView()
    }
    
    @IBAction private func backwardButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func configureImageView() {
        imageView.image = image
    }
    
}
