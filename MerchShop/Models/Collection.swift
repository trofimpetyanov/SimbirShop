//
//  Collection.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 15.02.2022.
//

import Foundation

struct Collection {
    let name: String
    let description: String
    let items: [CatalogItem]
}

extension Collection: Codable { }

extension Collection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
