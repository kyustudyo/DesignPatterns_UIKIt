//
//  RxFunctionViewModel.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/10/01.
//

import Foundation
import RxSwift

class RxFunctionViewModel {
    let sub = PublishSubject<Int>()
    var str = "qw"
    weak var delegate: CompleteDelegate?
    let urlStringObservable = BehaviorSubject<String?>(value: "value")
    
    let disposeBag = DisposeBag()
    let service: Service//delegate받기위해서.
    
    init() {
        service = Service()
        service.delegate = self
        service.getImageURLString(urlString: "www.naver.com")
//            .bind(to: urlStringObservable)
            .subscribe(onNext: {
                self.urlStringObservable.onNext($0)
                self.urlStringObservable.onCompleted()//이거하면 앞으로 urlStringObservable에 대해 일안함
            })
            .disposed(by: disposeBag)
        
        
        sub
            .subscribe(onNext: {_ in
                print("Rrrrrrrr")
            })
            .disposed(by: disposeBag)
    }
    
    func changeString() {
        
        service.getImageURLString(urlString: "www.naverWebtoon.com")
            .map {
//                print("getImageURLString")
                return ($0 ?? "") + "change"
            }
//            .bind(to: urlStringObservable)
            .subscribe(onNext: {
                self.str += self.str
                self.urlStringObservable.onNext($0 + self.str)
            })
            .disposed(by: disposeBag)
    }
    
}

extension RxFunctionViewModel: Complete {
    func isComplete() {
        secondAsynchronose { next in
            print(next)
        }
    }
    
}

extension RxFunctionViewModel {
    
    func callFristAsynchronose() {
        service.firstAsynchronose()
    }
    
    private func secondAsynchronose(completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion("끝!")
        }
    }
    
}

extension RxFunctionViewModel {
    func asynchronoseWithDelegateInViewController() {
        service.firstAsynchronoseWithCompletion_ViewModel_delegate { finish in
            self.secondAsynchronoseWithDelegateInViewController(data: finish)
        }
    }
    
    private func secondAsynchronoseWithDelegateInViewController(data: String) {
        DispatchQueue.global().asyncAfter(deadline: .now()+2) {
            self.delegate?.complete(data: data)
        }
    }
    
}

extension RxFunctionViewModel {
    
}

protocol CompleteDelegate: AnyObject {
    func complete(data: String)
}


extension RxFunctionViewModel {
    func abcc() {
        
        service.getImageURLString(urlString: "sd")
            .map { str in
                return 3
            }
            .subscribe(sub)
            .disposed(by: disposeBag)
//            .subscribe(onNext: {
//
//            })
    }
}


class a {
    static let k = a()
    private init() {
        
    }
    func b() {
        
    }
}


