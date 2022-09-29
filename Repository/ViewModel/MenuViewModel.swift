//
//  MenuViewModel.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/29.
//

import Foundation
import RxSwift

class MenuViewModel {
    
    let disposeBag = DisposeBag()
    let MenusSubject = BehaviorSubject<[MenuDomainModels.Menu]>(value: [])
    let MenuAPIService: MenuRepository
    
    init() {
        self.MenuAPIService = MenuRepositoryImpl()
        self.fetchMenus()
    }
    
    private func fetchMenus() {
        MenuAPIService.fetchMenuAPI()
            .subscribe(onNext: { menus in
                self.MenusSubject.onNext(menus)
            },
                       onError: { error in
                print(error.localizedDescription)
            },
                       onCompleted: { 
                print("complete")
            }
            )//observable은 .bind 불가
            .disposed(by: disposeBag)
    }
    
}
