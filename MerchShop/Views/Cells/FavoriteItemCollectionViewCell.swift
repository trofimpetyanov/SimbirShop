//
//  FavoriteItemCollectionViewCell.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 17.02.2022.
//

import UIKit

class FavoriteItemCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "favoriteItemCell"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var nonDiscountPriceLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addToCartButton: UIButton!
    
    let numberFormatter = Settings.shared.numberFormatter
    var item: CatalogItem?
    
    private func setup() {
        contentView.layer.cornerRadius = 16.0
        contentView.layer.masksToBounds = true
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        
        imageView.layer.cornerRadius = 12
        addToCartButton.layer.cornerRadius = 12
    }
    
    func configure(with catalogItem: CatalogItem) {
        setup()
        self.item = catalogItem
        
        if let image = UIImage(named: catalogItem.imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "image")
        }
        
        if let discount = catalogItem.discount {
            nonDiscountPriceLabel.isHidden = false
            
            let discountPrice = catalogItem.price * (1 - discount / 100)
            
            nonDiscountPriceLabel.text = numberFormatter.string(from: NSNumber(value: catalogItem.price))
            priceLabel.text = numberFormatter.string(from: NSNumber(value: discountPrice))
        } else {
            nonDiscountPriceLabel.isHidden = true
            
            priceLabel.text = numberFormatter.string(from: NSNumber(value: catalogItem.price))
        }
        
        nameLabel.text = catalogItem.name
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        guard let item = item else { return }
        
        let cartItem = CartItem(item: item)
        
        if !Settings.shared.cartItems.contains(cartItem) {
            guard let index = Settings.shared.favoriteItems.firstIndex(of: item) else { return }
            
            Settings.shared.favoriteItems.remove(at: index)
            Settings.shared.cartItems.append(cartItem)
            
            NotificationCenter.default.post(name: NSNotification.Name("favoriteItemsNeedUpdate"), object: nil)
        } else {
            addToCartButton.setTitle("Товар уже в", for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.addToCartButton.setTitle("Добавить в", for: .normal)
            }
        }
    }
}
