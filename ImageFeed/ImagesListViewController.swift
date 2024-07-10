//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 09.07.2024.
//

import UIKit


// MARK: -
// TODO: Move to services

protocol ImageLoader {
    func loadImages(for count: Int) -> [UIImage]
}

struct MockImageLoader: ImageLoader {
    func loadImages(for count: Int) -> [UIImage] {
        var images = [UIImage]()
        
        for i in 0..<count {
            images.append(UIImage(named: "\(i)")!)
        }
        
        return images
    }
}

// MARK: -

final class ImagesListViewController: UIViewController {
    private var imageLoader: ImageLoader?
    
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageLoader = MockImageLoader()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.rowHeight = 200
    }
    
    private func configureUI(for cell: ImagesListCell) { }

}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.cellIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configureUI(for: imageListCell)
        return imageListCell
    }
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
