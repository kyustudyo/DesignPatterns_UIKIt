//
//  Webservices.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/13.
//

import Foundation

class Webservices {
  //
  // MARK: - Class Methods
  //
  static func loadData(completionHandler: @escaping (Event?) -> Void) {
    Network.loadJSONFile(named: "PhoneNumbers", type: [PhoneNumber].self) { (phoneNumbers, error) in
      guard error == nil else {
          completionHandler(nil)
        return
      }
        let event = Event()
        event.phoneNumbers = phoneNumbers ?? []
        
        completionHandler(event)
      }
    }
}
