//
//  RxFunctionViewModel.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/10/01.
//

import Foundation
import RxSwift

class RxFunctionViewModel {
    
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
            })
            .disposed(by: disposeBag)
    }
    
    func changeString() {
        
        service.getImageURLString(urlString: "www.naverWebtoon.com")
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

protocol CompleteDelegate: AnyObject {
    func complete(data: String)
}
