//
//  LoginViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/26.
//

import Foundation
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    lazy var productStackView: ProductStackView = {
        
        let v = ProductStackView()
        
        let textField1 = v.productInputField.productTextField.textField
        let textField2 = v.productInputField.holderTextField.textField
        let button = v.productInputField.chooseButton
        
        textField1.delegate = self
        textField2.delegate = self
        textField1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        textField1.accessibilityIdentifier = "textFieldAbove"
        textField2.accessibilityIdentifier = "textFieldBelow"
        button.accessibilityIdentifier = "productButton"
     
        return v
    }()
    
    let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(productStackView)
        productStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ sender: UITextField) {

        guard let t1 = productStackView.productInputField.holderTextField.textField.text,
              let t2 = productStackView.productInputField.productTextField.textField.text,
              !t1.isEmpty,
              !t2.isEmpty
        else { return }
        
        viewModel.login(t1, t2) { isValid in
            DispatchQueue.main.async {
                self.productStackView.productInputField.chooseButton.backgroundColor = isValid ? .green : .red
            }
        }
        
    }
}
