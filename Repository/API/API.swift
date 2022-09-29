//
//  API.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/29.
//

import Foundation
import RxSwift



class API {
    static func fetchMenuRX(urlString: String) -> Observable<DTO.MenuResponse?> {
        
        guard let url = URL(string: urlString) else {
            return Observable.create { emmiter in
                emmiter.onError(MenuError.urlError)
                return Disposables.create()
            }
        }
        
        return Observable<DTO.MenuResponse?>.create { emmiter in
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data,
                      error == nil else {
                    emmiter.onError(MenuError.networkError)
                    return
                }
                
                let decoder = JSONDecoder()
                guard let dtos = try? decoder.decode(DTO.MenuResponse.self, from: data) else {
                    emmiter.onError(MenuError.parsingError)
                    return
                }
                emmiter.onNext(dtos)
                emmiter.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
