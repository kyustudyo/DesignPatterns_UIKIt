//
//  InputTextField.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/22.
//

import Foundation
import UIKit

public enum ProductInputFieldType {
    case newCreate
    case deco
}

final class ProductInputTextField: UIView {
    lazy var chooseButton: UIButton = {
        let v = UIButton()
        v.setTitle("가능?", for: .normal)
        v.setTitleColor(UIColor.white, for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 16)
        v.titleLabel?.textAlignment = .center
        v.layer.cornerRadius = 15
        v.backgroundColor = .red
        return v
    }()
    
    lazy var holderTextField = LimitTextField(frame: .zero, type: .holder)
    lazy var productTextField = LimitTextField(frame: .zero, type: .account)
    private var type: ProductInputFieldType
    
    init(frame: CGRect, type: ProductInputFieldType) {
        self.type = type
        super.init(frame: frame)
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProductInputTextField {
    private func setUI() {
        self.addSubview(chooseButton)
        self.addSubview(holderTextField)
        self.addSubview(productTextField)
    
        self.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        switch type {
        case .newCreate:
            chooseButton.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.width.equalTo(90)
                make.height.equalTo(32)
            }
            
            holderTextField.snp.makeConstraints { make in
                make.leading.equalTo(chooseButton.snp.trailing).offset(10)
                make.trailing.equalToSuperview()
            }
            
            productTextField.snp.makeConstraints { make in
                make.top.equalTo(chooseButton.snp.bottom).offset(35)
                make.leading.trailing.equalToSuperview()
            }
            
        case .deco:
            chooseButton.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.width.equalTo(75)
                make.height.equalTo(32)
            }
            
            holderTextField.snp.makeConstraints { make in
                make.leading.equalTo(chooseButton.snp.trailing).offset(10)
                make.trailing.equalToSuperview()
            }
            
            productTextField.snp.makeConstraints { make in
                make.top.equalTo(chooseButton.snp.bottom).offset(35)
                make.leading.trailing.equalToSuperview()
            }
        }
    }
}
