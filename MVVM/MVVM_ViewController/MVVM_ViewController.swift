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
        view.addSubview(productTableView)
        productTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    func callToViewModelForUIUpdate(){
        
        self.productViewModel =  ProductViewModel()
        self.productViewModel.bindEmployeeViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = ProductTableViewDataSource(cellIdentifier: "productTableViewCell", items: self.productViewModel.product, configureCell: { (cell, evm) in
            
            cell.productLabel.text = evm?.thumbnail
            cell.productNameLabel.text = evm?.brand
        })
        DispatchQueue.main.async {
            self.productTableView.dataSource = self.dataSource
            self.productTableView.reloadData()
        }
        
    }
    
}

