//
//  ViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/08/28.
//

import UIKit

class ViewController: UIViewController {

    let orderTableView = UITableView()
    let PhoneNumberTableView = UITableView()
    
    var dataManager = DataManager.shared
    var infoModel:InfoModel = InfoModel(name: "first", age: 1)
    
    var event: Event? {
        didSet {
            if isViewLoaded {
                PhoneNumberTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        orderTableView.delegate = self
        orderTableView.dataSource = self
        
        PhoneNumberTableView.delegate = self
        PhoneNumberTableView.dataSource = self
        
        orderTableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.cellID)
        PhoneNumberTableView.register(PhoneNumberTableViewCell.self, forCellReuseIdentifier: PhoneNumberTableViewCell.cellID)
//        dataManager.delegate = self // 질문
        
        // 1. completion handler로 모델에서 Controller로.
        // 2. 여기서는 KVO가 궂이 필요없다. property의 변화를 보고싶다면 필요하다.
       fetchData()
        
        //MARK: TableView
        view.addSubview(orderTableView)
        view.addSubview(PhoneNumberTableView)
        orderTableView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0, height: 200)
        PhoneNumberTableView.anchor(top: orderTableView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
    }
    //MARK: User Interact -> Model Update -> View Update
    private func fetchData() {
        dataManager.fetchData { model in
            let observer = self.infoModel.observe(\.age, options: [.old, .new]) { (object, change) in
                print("\(change.oldValue) -> \(change.newValue)")
                self.orderTableView.reloadData()
            }
            self.infoModel.age = model.age
            observer.invalidate()
        }
    }
}
//extension ViewController: fetchDelegate {
//    func fetchSampleModel(_ sampleModel: InfoModel) {
////        print("from: delegate", sampleModel.name)
////        self.orderTableView.reloadData()
//    }
//}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case orderTableView:
            return 1
        case PhoneNumberTableView:
            return event?.phoneNumbers.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case orderTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellID, for: indexPath) as? OrderTableViewCell else { return UITableViewCell() }
            cell.nameLabel.text = "\(infoModel.age)"
            return cell
        case PhoneNumberTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberTableViewCell.cellID, for: indexPath) as? PhoneNumberTableViewCell else { return UITableViewCell() }
            cell.nameLabel.text = event?.phoneNumbers[indexPath.row].phoneNumber
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case orderTableView:
            fetchData()
        default:
            return
        }
    }
}


