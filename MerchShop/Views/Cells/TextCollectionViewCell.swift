//
//  TextCollectionViewCell.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 16.02.2022.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "textCell"
    
    @IBOutlet var textLabel: UILabel!
    
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
    }
    
    func configure(with text: String) {
        setup()
        
        textLabel.text = text
    }
}
