//
//  PhoneNumbers.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/13.
//

import Foundation

struct PhoneNumber: CustomStringConvertible, Decodable {
    
    var name: String
    var age: Int
    var phoneNumber: String
    
    var description: String {
        return """
        name: \(name),
        age: \(age),
        phoneNumber: \(phoneNumber)
        """
    }
    
    init(name: String, age: Int, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
    
}
