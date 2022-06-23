//
//  Item.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 15.02.2022.
//

import Foundation

struct CatalogItem {
    let name: String
    let description: String
    let imageName: String
    
    let sizes: [Size]
    
    let price: Double
    let discount: Double?
    var discountPrice: Double {
        if let discount = discount {
            return price * (1 - discount/100)
        }
        
        return price
    }
    
    let isHotPick: Bool
    let isNew: Bool
}

extension CatalogItem: Codable { }

extension CatalogItem: Hashable {
    static func == (lhs: CatalogItem, rhs: CatalogItem) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description && lhs.price == rhs.price
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(description)
    }
}
