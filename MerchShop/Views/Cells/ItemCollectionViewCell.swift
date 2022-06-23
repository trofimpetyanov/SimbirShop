//
//  ItemCollectionViewCell.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 16.02.2022.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    //MARK: – Static Properties
    static let reuseIdentifier = "itemCell"
    
    //MARK: – Model
    struct Model {
        var favoriteItems: [CatalogItem] {
            Settings.shared.favoriteItems
        }
    }
    
    //MARK: – Outlets
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nonDiscountPriceLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var accessoryButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    
    //MARK: – Properties
    let model = Model()
    var item: CatalogItem?
    
    let numberFormatter = Settings.shared.numberFormatter
    
    //MARK: – Helpers
    private func setup() {
        contentView.layer.cornerRadius = 16.0
        contentView.layer.masksToBounds = true
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.cornerRadius = 16
        setupShadowForLayer(layer, opacity: 0.1)
        
        favoriteButton.layer.cornerRadius = 10
        favoriteButton.layer.shadowPath = UIBezierPath(roundedRect: favoriteButton.bounds, cornerRadius: favoriteButton.layer.cornerRadius).cgPath
        setupShadowForLayer(favoriteButton.layer, opacity: 0.05)
        
        accessoryButton.layer.cornerRadius = 10
        accessoryButton.layer.shadowPath = UIBezierPath(roundedRect: accessoryButton.bounds, cornerRadius: accessoryButton.layer.cornerRadius).cgPath
        setupShadowForLayer(accessoryButton.layer, opacity: 0.05)
        
        imageView.layer.cornerRadius = 12
    }
    
    private func setupShadowForLayer(_ layer: CALayer, opacity: Float) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func configure(with item: CatalogItem) {
        setup()
        self.item = item
        
        if model.favoriteItems.contains(item) {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        if let image = UIImage(named: item.imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "image")
        }
        
        if item.isNew {
            accessoryButton.setImage(UIImage(systemName: "sparkles"), for: .normal)
        }
        
        if item.isHotPick {
            accessoryButton.setImage(UIImage(systemName: "flame"), for: .normal)
        }
        
        if let discount = item.discount {
            nonDiscountPriceLabel.isHidden = false
            accessoryButton.setImage(UIImage(systemName: "percent"), for: .normal)
            
            let discountPrice = item.price * (1 - discount / 100)
            
            nonDiscountPriceLabel.text = numberFormatter.string(from: NSNumber(value: item.price))
            priceLabel.text = numberFormatter.string(from: NSNumber(value: discountPrice))
        } else {
            nonDiscountPriceLabel.isHidden = true
            
            priceLabel.text = numberFormatter.string(from: NSNumber(value: item.price))
        }
        
        if item.discount == nil && !item.isNew && !item.isHotPick {
            accessoryButton.isHidden = true
        }
        
        nameLabel.text = item.name
    }
    
    //MARK: – Actions
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let item = item else { return }
        
        if model.favoriteItems.contains(item), let firstIndex = model.favoriteItems.firstIndex(of: item) {
            var favoriteItems = model.favoriteItems
            
            favoriteItems.remove(at: firstIndex)
            
            Settings.shared.favoriteItems = favoriteItems
        } else {
            var favoriteItems = model.favoriteItems
            
            favoriteItems.insert(item, at: 0)
            
            Settings.shared.favoriteItems = favoriteItems
        }
        
        configure(with: item)
    }
}
