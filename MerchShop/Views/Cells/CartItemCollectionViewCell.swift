//
//  CartCollectionViewCell.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 17.02.2022.
//

import UIKit

class CartItemCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cartItemCell"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var nonDiscountPriceLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sizeButton: UIButton!
    @IBOutlet var amountLabel: UILabel!
    
    let numberFormatter = Settings.shared.numberFormatter
    var cartItem: CartItem?
    
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
        sizeButton.layer.cornerRadius = 8
    }
    
    func configure(with cartItem: CartItem) {
        setup()
        self.cartItem = cartItem
        
        if let image = UIImage(named: cartItem.item.imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
        
        if let discount = cartItem.item.discount {
            nonDiscountPriceLabel.isHidden = false
            
            let discountPrice = cartItem.item.price * (1 - discount / 100)
            
            nonDiscountPriceLabel.text = numberFormatter.string(from: NSNumber(value: cartItem.item.price))
            priceLabel.text = numberFormatter.string(from: NSNumber(value: discountPrice))
        } else {
            nonDiscountPriceLabel.isHidden = true
            
            priceLabel.text = numberFormatter.string(from: NSNumber(value: cartItem.item.price))
        }
        
        nameLabel.text = cartItem.item.name
        amountLabel.text = "x\(cartItem.amount)"
        
        if let size = cartItem.size {
            let sizeText: String
            
            switch size {
            case .oneSize:
                sizeText = "One"
            case .shoeSize(let shoeSize):
                sizeText = "\(shoeSize)"
            case .clothesSize(let clothesSize):
                sizeText = clothesSize.rawValue
            }
            
            self.sizeButton.setTitle(sizeText, for: .normal)
        } else {
            self.sizeButton.setTitle("–", for: .normal)
        }
        
        var actions = [UIAction]()
        
        for size in cartItem.item.sizes {
            let sizeText: String
            switch size {
            case .oneSize:
                sizeText = "One"
            case .shoeSize(let shoeSize):
                sizeText = "\(shoeSize)"
            case .clothesSize(let clothesSize):
                sizeText = clothesSize.rawValue
            }
            
            actions.append(UIAction(title: sizeText, handler: { (action) in
                guard let index = Settings.shared.cartItems.firstIndex(of: cartItem) else { return }
                Settings.shared.cartItems[index].size = size
                
                self.sizeButton.setTitle(sizeText, for: .normal)
            }))
        }
        
        sizeButton.showsMenuAsPrimaryAction = true
        sizeButton.menu = UIMenu(title: "", children: actions)
    }
    
    @IBAction func sizeButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        guard let cartItem = cartItem, let index = Settings.shared.cartItems.firstIndex(of: cartItem) else { return }
        
        print("saved")
        Settings.shared.cartItems[index].amount = Int(sender.value)
        print(Settings.shared.cartItems[index].amount)
        
        amountLabel.text = "x\(Int(sender.value))"
    }
}
