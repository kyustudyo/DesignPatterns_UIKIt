//
//  MenuRepository.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/29.
//

import Foundation
import RxSwift

protocol MenuRepository {
    func fetchMenuAPI() -> Observable<[MenuDomainModels.Menu]>
}

class MenuRepositoryImpl: MenuRepository {
    
    func fetchMenuAPI() -> Observable<[MenuDomainModels.Menu]> {
        API.fetchMenuRX(urlString: DTO.MenuUrl)
            .map { response in
                self.convertToMenuDomainModel(response: response)
            }
            .asObservable()
    }
    
}

extension MenuRepositoryImpl {
    private func convertToMenuDomainModel(response : DTO.MenuResponse?) -> [MenuDomainModels.Menu] {
        guard let response = response else {
            return []
        }
        var index = -1
        return response.menus.map {
            index += 1
            return .init(name: $0.name, price: $0.price, id: index)
        }
    }
}
