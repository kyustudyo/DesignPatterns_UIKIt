//
//  DTOModel.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/08/28.
//

import Foundation

//KVO를 위해 class로 선언
@objc class SampleModel: NSObject {
    @objc dynamic var name: String
    @objc dynamic var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
