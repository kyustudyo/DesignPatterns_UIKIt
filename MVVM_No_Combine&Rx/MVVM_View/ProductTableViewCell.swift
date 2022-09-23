//
//  ProductTableViewCell.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/21.
//

import UIKit
import SnapKit

class ProductTableViewCell: UITableViewCell {
    
    lazy var productLabel: UILabel = {
        let v = UILabel()
        v.adjustsFontSizeToFitWidth = true
        return v
    }()
    
    lazy var productNameLabel: UILabel = {
        let v = UILabel()
        v.adjustsFontSizeToFitWidth = true
        v.numberOfLines = 0
        v.textAlignment = .center
        return v
    }()
    
    var employee : Product? {
        didSet {
            productLabel.text = employee?.title
            productNameLabel.text = employee?.brand
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    private func setUI() {
        
        addSubviews(productLabel, productNameLabel)
        productLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.top.bottom.equalTo(self.contentView).inset(8)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(productLabel.snp.bottom).offset(8)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


