//
//  BannerCollectionViewCell.swift
//  MachineTestSampleApp
//
//  Created by ashik_h on 25/06/22.
//

import Foundation
import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bannerImageView: UIImageView!
    
    private var apiService: ApiService!
    
    override func awakeFromNib() {
        apiService = ApiService()
    }
    
    func setupBannerData(data: ItemDetailsModel) {
        let url = URL(string: data.banner_url ?? "")
        if let url = url {
            getImage(url: url)
        }
    }
    
    private func getImage(url: URL) {
        apiService.getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.bannerImageView.image = UIImage(data: data)
            }
        }
    }
}
