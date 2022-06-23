//
//  CartItem.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 17.02.2022.
//

import Foundation

struct CartItem {
    let item: CatalogItem
    var size: Size?
    var amount: Int = 1
}

extension CartItem: Codable { }

extension CartItem: Hashable {
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        lhs.item == rhs.item
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(item)
        hasher.combine(size)
    }
}
