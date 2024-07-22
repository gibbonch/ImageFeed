//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 19.07.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    // MARK: - Image
    
    var image: UIImage?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateZoomScale(for: view.bounds.size)
    }
    
    // MARK: - IBActions
    
    @IBAction private func backwardButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func shareButtonDidTap(_ sender: Any) {
        guard let image else { return }
        
        let shareableImage = ShareableImage(image: image, title: "Поделиться изображением")
        let activityViewContoller = UIActivityViewController(activityItems: [shareableImage], applicationActivities: nil)
        present(activityViewContoller, animated: true)
    }
    
    // MARK: - Methods
    
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

// MARK: - UIScrollViewDelegate

extension SingleImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let size = view.bounds.size
        updateConstraints(for: size)
    }
    
    private func updateConstraints(for size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
}

