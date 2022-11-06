//
//  RxFunctionNextViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/10/01.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class RxFunctionNextViewController: UIViewController {
    
    let viewModel: RxFunctionViewModel
    var disposeBag = DisposeBag()
    
    private var button: UIButton = {
        $0.setTitle("String 수정", for: .normal)
        return $0
    }(UIButton())
    let a = UIView()
    private var label: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    
    init(viewModel: RxFunctionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
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
            .subscribe(onNext: {
//            self.viewModel.changeString()
                self.viewModel.asynchronoseWithDelegateInViewController()
        })
        .disposed(by: disposeBag)
        
        
        
    }
    
    
    private func setUI() {
        view.addSubviews(button, label)
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


