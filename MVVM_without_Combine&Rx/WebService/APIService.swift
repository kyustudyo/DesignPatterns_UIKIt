//
//  APIService.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/21.
//

import Foundation


class APIService {
    
    private let sourcesURL = URL(string: "https://dummyjson.com/products/1")!
    
    func fetchProducts(completion : @escaping (Product) -> ()){
        
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let empData = try! jsonDecoder.decode(Product.self, from: data)
            
                completion(empData)
                    
            }
            
        }.resume()
    }
    
}
