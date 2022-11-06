//
//  OpenAndClose.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/10/22.
//

import Foundation

protocol Fetchable {
    func fetchData(urlString: String)
}

class ImageURL: Fetchable {
    func fetchData(urlString: String) {
        print("fetch IMGURL")
    }
}

class Scheduler: Fetchable {
    func fetchData(urlString: String) {
        print("fetch SchedulerURL")
    }
}

class Book: Fetchable {
    func fetchData(urlString: String) {
        print("fetch BookURL")
    }
}

class FetchManager {
    func fetchData(host: Fetchable, urlString: String) {
        host.fetchData(urlString: urlString)
    }
}

//FetchManager().fetchData(host: Book(), urlString: "book url")

