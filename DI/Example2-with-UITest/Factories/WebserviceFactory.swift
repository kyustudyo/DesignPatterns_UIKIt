//
//  Factory.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/29.
//

import Foundation
import Foundation

class WebserviceFactory {
    
    func create() -> Webservice {
        
        let environment = ProcessInfo.processInfo.environment["ENV"]
        if environment == "TEST" {
            return FakeAuthServiceForTestOnlyTrue()
        } else {
            return ProductService()
        }
        
    }
    
}
