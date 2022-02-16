//
//  CatalogCollectionViewswift
//  MerchShop
//
//  Created by Trofim Petyanov on 16.02.2022.
//

import UIKit

class CatalogCollectionViewCell: UICollectionViewCell {
    @IBOutlet var catalogNameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func setup() {
        contentView.layer.cornerRadius = 16.0
        contentView.layer.masksToBounds = true;

        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        layer.cornerRadius = 16
    }
    
    func configure(with collection: Collection) {
        
    }
    
    func configure(with category: Category) {
        setup()
        catalogNameLabel.text = category.name
        
        guard let firstItem = category.items.first, let image = UIImage(named: firstItem.imageName) else { return }
        imageView.image = image
    }
}
