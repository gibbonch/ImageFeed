//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 15.06.2024.
//

import UIKit
import LinkPresentation

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
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
    }
    
    private func setupImageView() {
        guard let image else { return }
        
        imageView.image = image
        imageView.frame.size = image.size
    }
    
    private func rescaleAndCenterImageInScrollView() {
        guard let image else { return }
        
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        
        view.layoutIfNeeded()
        
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
        
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
    }
    
    private func presentShareActivityView(with shareable: ShareableImage) {
        let activityVC = UIActivityViewController(activityItems: [shareable], applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction private func backwardButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func shareButtonDidTap(_ sender: Any) {
        guard let image else { return }
        let shareable = ShareableImage(image: image, title: "Поделиться изображением")
        presentShareActivityView(with: shareable)
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
