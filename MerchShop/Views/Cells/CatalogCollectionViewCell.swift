//
//  CatalogCollectionViewswift
//  MerchShop
//
//  Created by Trofim Petyanov on 16.02.2022.
//

import UIKit

class CatalogCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "catalogCell"
    
    @IBOutlet var catalogNameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func setup() {
        contentView.layer.cornerRadius = 16.0
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.cornerRadius = 16
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        
        imageView.layer.cornerRadius = 12
    }
    
    func configure(with collection: Collection) {
        setup()
        
        catalogNameLabel.text = collection.name
        
        guard let firstItem = collection.items.first, let image = UIImage(named: firstItem.imageName) else { return }
        imageView.image = image
    }
    
    func configure(with category: Category) {
        setup()
        
        catalogNameLabel.text = category.name
        
        guard let firstItem = category.items.first, let image = UIImage(named: firstItem.imageName) else { return }
        imageView.image = image
    }
}
