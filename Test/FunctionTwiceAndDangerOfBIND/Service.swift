//
//  Service.swift
//  RxSwift+MVVM
//
//  Created by Hankyu Lee on 2022/09/30.
//

import Foundation
import RxSwift
import UIKit

class Service {
    
    static func getImageURLString(urlString: String) -> Observable<String?> {
        return Observable.create { emitter in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3){
                    emitter.onNext("hihi")
                    emitter.onCompleted()
                }
            return Disposables.create()
        }
    }
    
//    static func downLoadImage(urlString: String) -> Observable<String> {
//        return Observable.create { emitter in
////            DispatchQueue.global().asyncAfter(deadline: .now()+1) {
////                DispatchQueue.main.async {
//                    emitter.onNext("comcomcom")
//                    emitter.onCompleted()
////                }
////            }
//            return Disposables.create()
//        }
//    }
}
