//
//  MVVM_ViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/22.
//

import Combine
import UIKit

class MVVM_ViewController_: UIViewController {
    
    //MARK: ViewController에 선언해서 Binding 하는 방법
//    private let user = PassthroughSubject<String, Never>()
//    private let password = PassthroughSubject<String, Never>()
//    private let passwordAgaing = PassthroughSubject<String, Never>()

    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel = MainViewModel()
    
    lazy var productStackView: ProductStackView = {
        let v = ProductStackView()
        
        //MARK: addTarget으로 하는방법
//        v.productInputField.productTextField.textField.delegate = self
//        v.productInputField.holderTextField.textField.delegate = self
//        v.productInputField.productTextField.textField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
//        v.productInputField.holderTextField.textField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        return v
    }()
  
    lazy var lastTextFied: LimitTextField = {
        let v = LimitTextField(frame: .zero, type: .check)
        
        //MARK: addTarget으로 하는방법
//        v.textField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind(to: viewModel)
    }
    
}

extension MVVM_ViewController_: UITextFieldDelegate {
    
    //MARK: ViewController내에서 처리할경우
//    @objc private func textFieldDidChange(sender: UITextField) {
//        switch sender {
//        case productStackView.productInputField.productTextField.textField:
//            user.send(sender.text!)
//        case productStackView.productInputField.holderTextField.textField:
//            password.send(sender.text!)
//        case lastTextFied.textField:
//            passwordAgaing.send(sender.text!)
//        default: break
//        }
//    }
    
}

extension MVVM_ViewController_ {
    private func setUI() {
        
        view.backgroundColor = .white
        view.addSubviews(productStackView, lastTextFied)
        
        productStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        lastTextFied.snp.makeConstraints { make in
            make.top.equalTo(productStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
    private func bind(to viewModel: MainViewModel) {
        let input = MainViewModel.Input(
            
            //MARK: ViewController내에서 Binding
//            userName: user.eraseToAnyPublisher(),
//            password: password.eraseToAnyPublisher(),
//            passwordAgaing: passwordAgaing.eraseToAnyPublisher()
            
            //MARK: Custom textPublisher. Combine은 Custom해서 사용해야함.
            userName: productStackView.productInputField.holderTextField.textField.textPublisher.eraseToAnyPublisher(),
            password: productStackView.productInputField.productTextField.textField.textPublisher.eraseToAnyPublisher(),
            passwordAgaing: lastTextFied.textField.textPublisher
        )

        let output = viewModel.transform(input: input)

        output
            .buttonIsValid
            .sink(receiveValue: { [weak self] state in
                self?.productStackView.productInputField.chooseButton.isEnabled = state
                self?.productStackView.productInputField.chooseButton.backgroundColor = state ? .green : .orange
            })
            .store(in: &cancellables)
    }
}
