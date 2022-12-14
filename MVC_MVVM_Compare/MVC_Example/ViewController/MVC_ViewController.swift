//
//  MVC_ViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/22.
//

import UIKit

class MVC_ViewController: UIViewController {
    
    lazy var productStackView: ProductStackView = {
        let v = ProductStackView()
        
        let textField1 = v.productInputField.productTextField.textField
        let textField2 = v.productInputField.holderTextField.textField
        
        textField1.delegate = self
        textField2.delegate = self
        textField1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return v
    }()
    
    override func viewDidLoad() {
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews(productStackView)
        productStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}

extension MVC_ViewController: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ sender: UITextField) {
        if isValid() {
            productStackView.productInputField.chooseButton.backgroundColor = .red
        } else {
            productStackView.productInputField.chooseButton.backgroundColor = .yellow
        }
        
    }
    private func isValid() -> Bool {
            return
        productStackView.productInputField.productTextField.textField.text!.count >= 4 &&
        productStackView.productInputField.holderTextField.textField.text!.count >= 6 &&
        productStackView.productInputField.productTextField.textField.text == productStackView.productInputField.holderTextField.textField.text
        }
}
