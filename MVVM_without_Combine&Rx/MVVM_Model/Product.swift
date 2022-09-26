//
//  Product.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/21.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title, welcomeDescription: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id, title
        case welcomeDescription = "description"
        case price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
}
