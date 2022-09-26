//
//  NetworkError.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/13.
//

import Foundation

enum NetworkError: Error {
    case invalidPath
    case parseError
    case requestError
    case responseError
}
