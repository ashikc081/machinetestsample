//
//  CategoryCollectionViewCell.swift
//  MachineTestSampleApp
//
//  Created by ashik_h on 25/06/22.
//

import Foundation
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    private var apiService: ApiService!
    
    override func awakeFromNib() {
        apiService = ApiService()
    }
    
    func setupCategoryData(data: ItemDetailsModel) {
        self.categoryNameLabel.text = data.name
        self.imageBackgroundView.setViewRounded(borderColr: .clear, isCircle: true, cornerRadius: nil)
        let url = URL(string: data.image_url ?? "")
        if let url = url {
            self.getImage(url: url)
        }
    }
    
    private func getImage(url: URL) {
        apiService.getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.categoryImageView.image = UIImage(data: data)
            }
        }
    }
}
