//
//  CategoryTableViewCell.swift
//  MachineTestSampleApp
//
//  Created by ashik_h on 25/06/22.
//

import Foundation
import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var categoriesData: [ItemDetailsModel] = []
    
    let colorArray = [UIColor.init(hexString: "#FAE7E7"),
                      UIColor.init(hexString: "#F7F3C9"),
                      UIColor.init(hexString: "#FCF0F0"),
                      UIColor.init(hexString: "#802EBE"),
                      UIColor.init(hexString: "#FFF2D9")]
    
    override func awakeFromNib() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    func setCategoriesData(data: [ItemDetailsModel]) {
        self.categoriesData = data
        self.categoryCollectionView.reloadData()
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.imageBackgroundView.backgroundColor = colorArray[indexPath.row%5]
        cell.setupCategoryData(data: categoriesData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 91)
    }
}
