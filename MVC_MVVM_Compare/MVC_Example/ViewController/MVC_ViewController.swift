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
        v.productInputField.productTextField.textField.delegate = self
        v.productInputField.holderTextField.textField.delegate = self
        v.productInputField.productTextField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        v.productInputField.holderTextField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
