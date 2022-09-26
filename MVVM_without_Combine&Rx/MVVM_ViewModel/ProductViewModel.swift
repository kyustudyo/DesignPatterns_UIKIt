//
//  File.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/21.
//

import Foundation

class ProductViewModel {
    
    private var apiService : APIService!
    private(set) var product : Product! {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
    init() {
        self.apiService =  APIService()
        fetchProduct()
    }

    private func fetchProduct() {
        self.apiService.fetchProducts { (empData) in
            self.product = empData// main thread 가 아님
        }
    }
    
    func didTapCell() {
        fetchProduct()
    }
    

}
