//
//  Order.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 18.02.2022.
//

import Foundation

struct Order {
    let items: [CartItem]
    let totalWithoutDiscount: Double
    let delivery: Delivery?
    let totalWithDiscount: Double
}

extension Order: Codable { }

extension Order: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(items)
    }
}
