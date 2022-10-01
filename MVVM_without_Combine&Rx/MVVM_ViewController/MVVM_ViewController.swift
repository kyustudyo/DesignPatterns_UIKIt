//
//  MVVM_ViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/21.
//

import UIKit
import SnapKit

public class ProductViewController: UIViewController {
    
    private lazy var productTableView: UITableView = {
        $0.register(ProductTableViewCell.self, forCellReuseIdentifier: "productTableViewCell")
        $0.delegate = self
        return $0
    }(UITableView())
    
    private var productViewModel : ProductViewModel!
    
    private var dataSource : ProductTableViewDataSource<ProductTableViewCell, Product>!
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        callToViewModelForUIUpdate()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(productTableView)
        productTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    func callToViewModelForUIUpdate(){
        
        self.productViewModel =  ProductViewModel()
        
        //RX를 사용하지 않을때 바인딩.
        self.productViewModel.bindEmployeeViewModelToController = {
            self.updateDataSource()
        }
        
    }
    
    func updateDataSource(){
        
        self.dataSource = ProductTableViewDataSource(cellIdentifier: "productTableViewCell", items: self.productViewModel.product, configureCell: { (cell, evm) in
            cell.productLabel.text = evm?.thumbnail
//            cell.productNameLabel.text = evm?.brand
            cell.productNameLabel.text = "cell 클릭시 api 호출 합니다.\n 색깔의 변화는 완료를 의미합니다."
            cell.backgroundColor = UIColor.allColors.randomElement()
        })
        
        DispatchQueue.main.async {
            self.productTableView.dataSource = self.dataSource
            self.productTableView.reloadData()
        }
        
    }
    
}

extension ProductViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productViewModel.didTapCell()
    }
}
