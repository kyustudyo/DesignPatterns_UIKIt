//
//  APIService.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/21.
//

import Foundation


class APIService {
    
    private let sourcesURL = URL(string: "https://dummyjson.com/products/1")!
    
    func fetchProducts<T: Decodable>(completion : @escaping (T) -> ()){
        
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let empData = try! jsonDecoder.decode(T.self, from: data)
            
                completion(empData)
                    
            }
            
        }.resume()
    }
    
    func convertImage(product: Product, completion: @escaping (Bool) -> () ) {
        if product.price > 100 {
            URLSession.shared.dataTask(with: sourcesURL) { data, _, error in
                if let data = data, error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
