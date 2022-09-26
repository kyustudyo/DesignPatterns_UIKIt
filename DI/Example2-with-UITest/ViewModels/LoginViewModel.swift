//
//  LoginViewModel.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/26.
//

import Foundation

class LoginViewModel {
    
    var username: String = ""
    var password: String = ""
    
    var service: Webservice
    
    init(service: Webservice) {
        self.service = service
    }
    
    func login(_ username: String, _ password: String, completion: @escaping (Bool) -> Void ) {
        service.authenticate(username, password) {
            completion($0)
        }
    }
}
