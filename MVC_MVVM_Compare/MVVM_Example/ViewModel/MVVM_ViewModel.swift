//
//  MVVM_ViewModel.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/22.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

final class MainViewModel: ViewModelType {
    struct Input {
        let userName: AnyPublisher<String, Never>
        let password: AnyPublisher<String, Never>
        let passwordAgaing: AnyPublisher<String, Never>
    }
    
    struct Output {
        let buttonIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(input: Input) -> Output {
        let buttonStatePublisher = input.userName.combineLatest(input.password, input.passwordAgaing)
            .map { user, password, passwordAgaing in
                user.count >= 4 &&
                password.count >= 6 &&
                password == passwordAgaing
            }
            .eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonStatePublisher)
    }
    
}
