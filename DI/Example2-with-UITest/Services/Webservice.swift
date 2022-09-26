//
//  Webservice.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/26.
//

import Foundation

protocol Webservice {
    func authenticate(_ username: String, _ password: String, completion: @escaping (Bool) -> Void )
}

class ProductService: Webservice {
    func authenticate(_ username: String, _ password: String, completion: @escaping (Bool) -> Void ) {
        DispatchQueue.global().asyncAfter(deadline: .now()+1) {
            completion(username == password)
        }
    }
}

class FakeAuthServiceForTestOnlyTrue: Webservice {
    
    func authenticate(_ username: String, _ password: String, completion: @escaping (Bool) -> Void ) {
        completion(true)
    }
    
}

class FakeAuthServiceForTestOnlyFalse: Webservice {
    
    func authenticate(_ username: String, _ password: String, completion: @escaping (Bool) -> Void ) {
        completion(false)
    }
    
}
