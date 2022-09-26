//
//  Network.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/13.
//

import Foundation

class Network {

//MARK: generic을 사용해 Network layer에서는 parse 하는 데이터 타입을 모른다.
static func loadJSONFile<T: Decodable>(named filename: String,
                                         type: T.Type,
                                         delaySeconds: TimeInterval = 2,
                                         completionHandler: @escaping (T?, NetworkError?) -> Void) {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delaySeconds) {
          completionHandler(nil, .invalidPath)
        }
        return
    }
      
    let dispatchQueue = DispatchQueue.main
    let request = URLRequest(url: url)
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
      let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
      if statusCode != 200 {
          dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delaySeconds) {
          completionHandler(nil, .requestError)
        }
          return
      }
        
      do {
        if let jsonData = data {
          let decoder = JSONDecoder()
          let typedObject: T? = try decoder.decode(T.self, from: jsonData)
            dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delaySeconds) {
              completionHandler(typedObject, nil)
            }
        }
      } catch {
        print(error)
          dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delaySeconds) {
            completionHandler(nil, .parseError)
          }
      }
    }
    dataTask.resume()
  }
}
