//
//  ProductTableViewDataSource.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/21.
//

import UIKit

class ProductTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : T!
    var configureCell : (CELL, T?) -> () = { _, _ in }
    
    
    init(cellIdentifier : String, items : T, configureCell : @escaping (CELL, T?) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = items
        self.configureCell(cell, item ?? nil)
        return cell
    }
}
