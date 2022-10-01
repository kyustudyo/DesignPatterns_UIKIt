//
//  RxFunctionViewModel.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/10/01.
//

import Foundation
import RxSwift

class RxFunctionViewModel {
    
    let urlStringObservable = BehaviorSubject<String?>(value: "value")
    let disposeBag = DisposeBag()
    
    init() {
        Service.getImageURLString(urlString: "www.naver.com")
//            .bind(to: urlStringObservable)
            .subscribe(onNext: {
                self.urlStringObservable.onNext($0)
            })
            .disposed(by: disposeBag)
    }
    
    func changeString() {
        
        Service.getImageURLString(urlString: "www.naverWebtoon.com")
            .map {
                print("getImageURLString")
                return ($0 ?? "") + "change"
            }
//            .bind(to: urlStringObservable)
            .subscribe(onNext: {
                self.urlStringObservable.onNext($0)
            })
            .disposed(by: disposeBag)
    }
    
}
