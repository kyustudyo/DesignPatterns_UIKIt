//
//  MenuTableViewCell.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/29.
//

import Foundation
import UIKit
import SnapKit

class MenuTableViewCell: UITableViewCell {
    static let cellId = "MenuItemTableViewCell"
    var nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    
    let priceLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(nameLabel, priceLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(12)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel.snp.leading)
            make.bottom.equalTo(self.snp.bottom).inset(8)
            //아래까지 설정해야 흘러내리지 않는다.
        }
        
    }
    
}
