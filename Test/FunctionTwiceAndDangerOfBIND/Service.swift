//
//  Service.swift
//  RxSwift+MVVM
//
//  Created by Hankyu Lee on 2022/09/30.
//

import Foundation
import RxSwift
import UIKit

//MARK: delegate pattern
protocol Complete: AnyObject {
    func isComplete()
}

class Service {
    weak var delegate: Complete?
    func getImageURLString(urlString: String) -> Observable<String?> {
        return Observable.create { emitter in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3){
                    emitter.onNext("hihi")
                    emitter.onCompleted()
                }
            return Disposables.create()
        }
    }
    
    func k() {
        getImageURLString(urlString: "")
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

extension Service {
    
    func firstAsynchronoseWithCompletion(completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion("1차완료")
        }
    }
    
    func firstAsynchronose() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.delegate?.isComplete()
        }
    }
    
    func firstAsynchronoseWithCompletion_ViewModel_delegate(completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion("완료했습니다. firstAsynchronoseWithCompletion")
        }
    }
    
    func makeJustOne() -> Observable<Int> {
//        return Observable.just(3)//type method
        return Observable.of(1,3,5,8,90)
    }
    
    func returnSingle() -> Single<Int> {
        Single.create { emitter in
            emitter(.success(5))
            return Disposables.create()
        }
    }
//    func makeObsevableWithMake() -> Observable<Int> {
//        
//    }
    
}
