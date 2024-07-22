//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Александр Торопов on 09.07.2024.
//

import UIKit



final class ImagesListViewController: UIViewController {
    
    // MARK: - UITableView
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    
    private let segueIdentifier = "SingleImageSegue"
    private var imageLoader: ImageLoader?
    
    private lazy var images: [UIImage] = {
        return imageLoader?.loadImages() ?? []
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoader = MockImageLoader()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let singleImageViewController = segue.destination as? SingleImageViewController,
                  let image = sender as? UIImage
            else {
                return
            }
            
            singleImageViewController.image = image
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        tableView.rowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    private func configureUI(for cell: ImagesListCell, with indexPath: IndexPath) {
        cell.cellImageView.image = images[indexPath.row]
        
        let currentDate = Date()
        cell.dateLabel.text = dateFormatter.string(from: currentDate)
        
        cell.isLiked = indexPath.row % 2 == 0
    }
    
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.cellIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configureUI(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let imagesListCell = tableView.cellForRow(at: indexPath) as? ImagesListCell else {
            return
        }
        
        let image = imagesListCell.cellImageView.image
        performSegue(withIdentifier: segueIdentifier, sender: image)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = images[indexPath.row]
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        
        return cellHeight
    }
    
}
