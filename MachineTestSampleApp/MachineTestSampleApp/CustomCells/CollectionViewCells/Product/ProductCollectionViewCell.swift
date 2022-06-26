//
//  ProductCollectionViewCell.swift
//  MachineTestSampleApp
//
//  Created by ashik_h on 25/06/22.
//

import Foundation
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var favouritesButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var expressImageView: UIImageView!
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    private var apiService: ApiService!
    
    override func awakeFromNib() {
        apiService = ApiService()
    }
    
    override func layoutSubviews() {
        setOfferRibbon()
    }
    
    func setupProductData(data: ItemDetailsModel) {
        self.offerLabel.text = "\(data.offer ?? 0)% OFF"
        self.expressImageView.isHidden = !(data.isExpress ?? false)
        let attributedActualPrice: NSMutableAttributedString = NSMutableAttributedString(string: data.actual_price ?? "0")
        attributedActualPrice.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedActualPrice.length))
        self.actualPriceLabel.attributedText = attributedActualPrice
        self.actualPriceLabel.textColor = UIColor.init(hexString: "#727272")
        self.offerPriceLabel.text = data.offer_price
        self.productNameLabel.text = data.name
        addButton.backgroundColor = UIColor.init(hexString: "#199B3B")
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.setViewRounded(borderColr: .clear, isCircle: false, cornerRadius: 4)
        self.containerView.setViewRounded(borderColr: UIColor.init(hexString: "#EDEDED"), isCircle: false, cornerRadius: 4)
        
        let url = URL(string: data.image ?? "")
        if let url = url {
            getImage(url: url)
        }
        
    }
    
    func setOfferRibbon() {

        

        offerView.backgroundColor = UIColor.init(hexString: "#E8393A")
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: offerView.frame.width, y: 0))
        path.addLine(to: CGPoint(x: offerView.frame.width - 5, y: offerView.frame.height/2))
        path.addLine(to: CGPoint(x: offerView.frame.width, y: offerView.frame.height))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.name = "ribbonEnd"
        
        let subLayers = offerView.layer.sublayers ?? []
        for layer in subLayers {
            if layer.name == "ribbonEnd" {
                layer.removeFromSuperlayer()
            }
        }
        
        offerView.layer.addSublayer(shapeLayer)
    }
    
    private func getImage(url: URL) {
        apiService.getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.productImageView.image = UIImage(data: data)
            }
        }
    }
}
