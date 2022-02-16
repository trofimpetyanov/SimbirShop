//
//  Category.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 15.02.2022.
//

import Foundation

struct Category {
    let name: String
    let items: [Item]
}

extension Category: Codable { }

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
