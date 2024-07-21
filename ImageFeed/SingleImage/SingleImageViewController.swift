//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 19.07.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImageView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateZoomScale(for: view.bounds.size)
    }
    
    @IBAction private func backwardButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func configureImageView() {
        imageView.image = image
    }
    
    private func updateZoomScale(for size: CGSize) {
        let hScale = size.width / scrollView.contentSize.width
        let vScale = size.height / scrollView.contentSize.height
        let minScale = min(hScale, vScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
}

extension SingleImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let size = view.bounds.size
        updateConstraints(for: size)
    }
    
    func updateConstraints(for size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
}
