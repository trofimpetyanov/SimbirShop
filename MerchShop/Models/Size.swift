//
//  Size.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 15.02.2022.
//

import Foundation

enum Size {
    case oneSize
    case shoeSize(Int)
    case clothesSize(ClothesSize)
}

extension Size: Codable { }

extension Size: Hashable { }

enum ClothesSize: String {
    case xs = "XS"
    case s = "S"
    case m = "M"
    case l = "L"
    case xl = "XL"
    case xxl = "XXL"
}

extension ClothesSize: Codable { }
