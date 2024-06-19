//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 15.06.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
            rescaleAndCenterImageInScrollView()
        }
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupImageView()
        rescaleAndCenterImageInScrollView()
    }
    
    private func setupScrollView() {
        scrollView.minimumZoomScale = 0.2
        scrollView.maximumZoomScale = 1.25
    }
    
    private func setupImageView() {
        guard let image else { return }
        
        imageView.image = image
        imageView.frame.size = image.size
    }
    
    private func rescaleAndCenterImageInScrollView() {
        guard let imageSize = image?.size else { return }
        let visibleRectSize = scrollView.bounds.size
        
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        
        let theoreticalScale = min(hScale, vScale)
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        
        let scale = min(maxZoomScale, max(minZoomScale, theoreticalScale))
        
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
    }
    
    // MARK: - Actions
    
    @IBAction private func backwardButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func shareButtonDidTap(_ sender: Any) {
        guard let image else { return }
        let activityViewController = UIActivityViewController(activityItems: [image],
                                                              applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension SingleImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) / 2.0, 0.0)
        let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) / 2.0, 0.0)
        imageView.center = CGPointMake(scrollView.contentSize.width / 2.0 + offsetX, scrollView.contentSize.height / 2.0 + offsetY)
    }
    
}
