//
//  Model.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/08/28.
//

import Foundation
//
//protocol fetchDelegate: AnyObject {
//    func fetchSampleModel(_ sampleModel: InfoModel)
//}

class DataManager {
    
    static let shared = DataManager()
    
    //MARK: delegate를 통한 데이터 전달 가능
//    weak var delegate: fetchDelegate?
    
    //MARK: completion handler를 통한 데이터 전달 가능
    func fetchData(completion: @escaping (InfoModel) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            let infoModel = InfoModel(name: "second", age: [1,2,3,4,5,6,7,8,9].randomElement()!)
            completion(infoModel)
//            self.delegate?.fetchSampleModel(sample)
        }
    }
    
}
