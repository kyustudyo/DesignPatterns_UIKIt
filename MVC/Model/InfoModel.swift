//
//  DTOModel.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/08/28.
//

import Foundation

//MARK: KVO - 객체의 프로퍼티의 변경사항을 다른 객체에 알리기 위해 사용하는 코코아 프로그래밍 패턴

@objc class InfoModel: NSObject { // KVO를 위해 class로 선언
    @objc dynamic var name: String
    @objc dynamic var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    static let dummyData = InfoModel(name: "이한규", age: 17)
}
