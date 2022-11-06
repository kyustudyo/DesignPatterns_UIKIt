//
//  ViewController_RxFunction.swift
//  RxSwift+MVVM
//
//  Created by Hankyu Lee on 2022/09/30.
//

import RxSwift
import UIKit
import RxCocoa
import SnapKit
import Combine
import SwiftUI

class ViewController_RxFunction: UIViewController {
    
    var cancel = Set<AnyCancellable>()
    let viewModel = RxFunctionViewModel()
    var disposeBag = DisposeBag()
    
    private var button: UIButton = {
        $0.setTitle("다음 뷰로", for: .normal)
        return $0
    }(UIButton())
    
    private var label: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    
    private let customLabel = CustomView1()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue

        self.viewModel.delegate = self
        
        setUI()
        
//        Just("www.naver.com")
        
        //실험용
        aa()
            .map { _ in print("-3", Thread.isMainThread)}
//            .subscribe(on: DispatchQueue.global())
            
            .map { _ in print("-2", Thread.isMainThread)}
//            .receive(on: DispatchQueue.main)
            .map { _ in print("-1", Thread.isMainThread)}
//            .subscribe(on: DispatchQueue.global())
//            .receive(on: DispatchQueue.main)
        //    .subscribe(on: DispatchQueue.global())
//            .subscribe(on: DispatchQueue.global())
            .map { _ in print("0",Thread.isMainThread) }
//            .subscribe(on: DispatchQueue.global())
        //    .receive(on: DispatchQueue.global())
        //    .subscribe(on: DispatchQueue.global())
//            .sub
            .map {
                print("1", Thread.isMainThread)
                
            }
            .subscribe(on: DispatchQueue.global())
//            .subscribe(on: DispatchQueue.global())
//            .subscribe(DispatchQueue.global())
//            .receive(on: DispatchQueue.main)
            .map {
                print("2", Thread.isMainThread)
            }
            
        //    .receive(on: DispatchQueue.main)
           .sink {
               print("end", Thread.isMainThread)
               
           }
           .store(in: &cancel)
            //
        
        //실험용
        BusyPublisher()
           .subscribe(on: DispatchQueue.global())
           .receive(on: DispatchQueue.main)
           .sink { _ in print("Received value") }
        print("Hello")
        //
        
        
        viewModel.abcc()
//
        viewModel.urlStringObservable
            .catchAndReturn("")
            .observe(on: MainScheduler.instance)
            .bind(to: label.rx.text)
//            .subscribe(onNext: {
//                self.label.text = $0
//            })
//            .subscribe(onNext: { _ in
//                print("1")
//            }, onError: { _ in
//                print("2")
//            }, onCompleted: {
//                print("3")
//            }, onDisposed: {
//                print("4")
//            })
            .disposed(by: disposeBag)
//
        button.rx.tap
            .subscribe(onNext: { _ in
//                let vc = RxFunctionNextViewController(viewModel: self.viewModel)
//                self.present(vc, animated: true)

                self.viewModel.changeString()
//                self.viewModel.callFristAsynchronose()
//                self.viewModel.asynchronoseWithDelegateInViewController()
            })
            .disposed(by: disposeBag)



        //MARK: flatMap 동작
//        let a = [1,2]
//        a.map { i in
//            print(i)
//        }
//        a.map{$0 * 2}// [2, 4]
//        a.map{ [$0*2, $0*3] }// [[2,4],[3,4]]
//        a.flatMap{ [$0*2, $0*3] }//[2,4,3,4]

        //MARK: flatMap의 필요성
//        let ob = Observable<String>.just("5")//Observable<String>
//            .map { URL(string: $0 )!}// Observable<URL>
//            .flatMap { self.cachedImageLoading($0) }
//            .subscribe(onNext: { a in
//                print(a)
//            })


        Service().getImageURLString(urlString: "www.geturl.com")
            .flatMap { s in
                return Service().getImageURLString(urlString: s!)
            }
            .subscribe(onNext: {
                print("stream을 전달 받아서 stream전달 한 후 subscribe" + $0!)
            })
            .disposed(by: disposeBag)

//observable은 unicast
//        let ob = Observable<Int>.create { emitter in
//            emitter.onNext([1,2,3].randomElement()!)
//            return Disposables.create()
//        }
//
//        let k = ob.subscribe(onNext: { val in
//            print("1", val)
//        }).disposed(by: disposeBag)
//
//        let b = ob.subscribe(onNext: { val in
//            print("2", val)
//        }).disposed(by: disposeBag)
        
//        Service().makeJustOne()
////            .subscribe(onNext: {
////                            self.label.text = "\($0)"
////                        })
//                        .subscribe(onNext: { k in
//                            print(k)
//                            print("도착")
//                        }, onError: { _ in
//                            print("2")
//                        }, onCompleted: {
//                            print("3")
//                        }, onDisposed: {
//                            print("4")
//                        })
//                        .disposed(by: disposeBag)
    }
    //UIResponder
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        <#code#>
//    }
    private func setUI() {
        view.addSubviews(label, button, customLabel)
        button.snp.makeConstraints { make in
            
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(button.snp.trailing)
        }
        
        customLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.bottom).offset(-100)
        }
    }
    
}

extension ViewController_RxFunction {
    private func cachedImageLoading(_ url: URL) -> Observable<UIImage?> {
        let cache = [UIImage()]
        if cache.isEmpty {
            return Observable.just(UIImage())
        } else {
            return Observable.just(UIImage())
        }
    }
}


extension ViewController_RxFunction: CompleteDelegate {
    func complete(data: String) {
        DispatchQueue.main.async {
            self.label.text = data
        }
        
    }
    
    //실험용
    func aa() -> AnyPublisher<String, Never> {
        Just("Aaaaa")
            .eraseToAnyPublisher()
        
        
        
//        URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.vadimbulavin.com")!)
//            .map{ _ in return " "}
//            .replaceError(with: " ")
//            .eraseToAnyPublisher()
    }
}
//실험용
struct BusyPublisher: Publisher {
    typealias Output = Int
    typealias Failure = Never
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        sleep(10)
        subscriber.receive(subscription: Subscriptions.empty)
        _ = subscriber.receive(1)
        subscriber.receive(completion: .finished)
    }
}


class button: UIButton {
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
}
