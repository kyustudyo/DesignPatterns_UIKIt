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
    
    private let tappedCellIndexLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.backgroundColor = .white
        $0.text = "셀을 클릭하세요"
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.backgroundColor = .white
        
        
        viewModel.MenusSubject
//            .catchAndReturn([])
//            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: MenuTableViewCell.cellId, cellType: MenuTableViewCell.self)) { index, item, cell in
                cell.nameLabel.text = item.name
                cell.priceLabel.text = "\(item.price)"
            }
            .disposed(by: disposeBag)
//            .bind(to: tableView.rx.items(cellIdentifier: MenuTableViewCell.cellId, cellType: MenuTableViewCell.self)) { index, item, cell in
//                cell.nameLabel.text = item.name
//                cell.priceLabel.text = "\(item.price)"
//            }
        
        tableView.rx.itemSelected
            .map{ "\($0)"}
            .asDriver(onErrorJustReturn: "")
            .drive(tappedCellIndexLabel.rx.text)
            .disposed(by: disposeBag)
            
    }
    
    private func setUI() {
        
        view.addSubviews(tappedCellIndexLabel, tableView)
        tappedCellIndexLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(tappedCellIndexLabel.snp.bottom)
        }
    }
    
}
