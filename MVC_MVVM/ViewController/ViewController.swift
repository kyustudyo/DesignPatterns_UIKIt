//
//  ViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/08/28.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    
    var dataManager = DataManager.shared
    var sampleModel:SampleModel = SampleModel(name: "first", age: 333)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellID)
        dataManager.delegate = self// 질문
        
        // 1. completion handler로 모델에서 Controller로.
        // 2. 여기서는 KVO가 궂이 필요없다. property의 변화를 보고싶다면 필요하다.
        dataManager.fetchData { model in
            let observer = self.sampleModel.observe(\.name, options: [.old, .new]) { (object, change) in
                print("\(change.oldValue) -> \(change.newValue)")
                self.tableView.reloadData()
            }
            
            // model 이름이 바뀌었다면 tableview reload.
            self.sampleModel.name = model.name
            observer.invalidate()
            
        }
        
        //MARK: TableView
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
    }
}
extension ViewController: fetchDelegate {
    func fetchSampleModel(_ sampleModel: SampleModel) {
//        print("from: delegate", sampleModel.name)
        self.tableView.reloadData()
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellID, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = sampleModel.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}


