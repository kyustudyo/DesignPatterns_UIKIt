//
//  MenuViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/29.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = MenuViewModel()
    
    
    lazy var tableView: UITableView = {
        $0.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.cellId)
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.MenusSubject
//            .catchAndReturn([])
//            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: MenuTableViewCell.cellId, cellType: MenuTableViewCell.self)) { index, item, cell in
                cell.nameLabel.text = item.name
                cell.priceLabel.text = "\(item.price)"
            }
        
//            .bind(to: tableView.rx.items(cellIdentifier: MenuTableViewCell.cellId, cellType: MenuTableViewCell.self)) { index, item, cell in
//                cell.nameLabel.text = item.name
//                cell.priceLabel.text = "\(item.price)"
//            }
        
            .disposed(by: disposeBag)
    }
    
    private func setUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
