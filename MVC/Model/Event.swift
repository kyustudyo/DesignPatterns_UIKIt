//
//  Event.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/13.
//

import Foundation
import Combine

class Event {
    
    var phoneNumbers: [PhoneNumber] = []
    
    //TODO: 가져온 데이터들을 다루는 코드 추가
}


class Event2: Publisher {
    
    typealias Output = String
    typealias Failure = Never
        
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        
//        DispatchQueue.global(qos: .utility).async {
            let dummy: [String] = ["jack", "tom"]
            dummy.forEach {
               _ = subscriber.receive($0)
            }
//            subscriber.receive(completion: .finished)
//        }
    }
    
}

