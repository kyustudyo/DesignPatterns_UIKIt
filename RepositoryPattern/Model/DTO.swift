//
//  DTO.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/29.
//

import Foundation

enum DTO {
    static let MenuUrl = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"
    
    struct MenuResponse: Decodable {
        let menus: [MenuItem]
    }
    struct MenuItem: Decodable {
        var name: String
        var price: Int
    }
    
}


