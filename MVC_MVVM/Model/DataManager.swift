//
//  Model.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/08/28.
//

import Foundation
//MARK: KVO - 객체의 프로퍼티의 변경사항을 다른 객체에 알리기 위해 사용하는 코코아 프로그래밍 패턴

protocol fetchDelegate: AnyObject {
    func fetchSampleModel(_ sampleModel: SampleModel)
}

class DataManager {
    
    static let shared = DataManager()
    
    weak var delegate: fetchDelegate?
    
    func fetchData(completion: @escaping (SampleModel) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            let sample = SampleModel(name: "second", age: 6)
            completion(sample)
            self.delegate?.fetchSampleModel(sample)
        }
    }
    
}
