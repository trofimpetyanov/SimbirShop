//
//  Delivery.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 18.02.2022.
//

import Foundation

struct Delivery {
    let name: String
    let price: Double
    let deliveryTime: Int
}

extension Delivery: Codable { }

extension Delivery: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
