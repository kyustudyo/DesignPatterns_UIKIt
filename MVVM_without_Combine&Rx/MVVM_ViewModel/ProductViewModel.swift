//
//  File.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/21.
//

import Foundation

class ProductViewModel {
    
    private var apiService : APIService!
    //이런식으로하면 rx가 필요없겠다.
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
    
    
    //MARK: RxSwift를 사용하지 않을때 생기는 callback 지옥
    func fetchProductAnd(completion: @escaping () -> () ) {
        self.apiService.fetchProducts { product in
            self.apiService.convertImage(product: product) { isMaxProduct in
                if isMaxProduct {
                    completion()
                }
            }
        }
    }


}
