//
//  Item.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 15.02.2022.
//

import Foundation

struct Item {
    let name: String
    let description: String
    let imageName: String
    
    let sizes: [Size]
    
    let price: Double
    let discount: Double?
    
    let isHotPick: Bool
    let isNew: Bool
}

extension Item: Codable { }

extension Item: Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name.lowercased() == rhs.name.lowercased() && lhs.description.lowercased() == rhs.description.lowercased()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(description)
    }
}
