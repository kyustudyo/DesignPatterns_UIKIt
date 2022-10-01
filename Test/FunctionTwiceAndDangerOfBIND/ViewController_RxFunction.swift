//
//  ViewController_RxFunction.swift
//  RxSwift+MVVM
//
//  Created by Hankyu Lee on 2022/09/30.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import RxSwift
import UIKit
import RxCocoa
import SnapKit

class ViewController_RxFunction: UIViewController {
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setUI()
        
        viewModel.urlStringObservable
            .catchAndReturn("")
            .observe(on: MainScheduler.instance)
            .bind(to: label.rx.text)
//            .subscribe(onNext: {
//                self.label.text = $0
//            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { _ in
                let vc = RxFunctionNextViewController(viewModel: self.viewModel)
                self.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
            
        
            
        //MARK: flatMap 동작
//        let a = [1,2]
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
        
        
        Service.getImageURLString(urlString: "www.geturl.com")
            .flatMap { s in
                return Service.getImageURLString(urlString: s!)
            }
            .subscribe(onNext: {
                print("stream을 전달 받아서 stream전달 한 후 subscribe" + $0!)
            })
            .disposed(by: disposeBag)
    }
    
    private func setUI() {
        view.addSubviews(label, button)
        button.snp.makeConstraints { make in
            
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(button.snp.trailing)
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
