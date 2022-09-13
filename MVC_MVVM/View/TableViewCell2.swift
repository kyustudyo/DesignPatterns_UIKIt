//
//  TableViewCell.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/08/28.
//

import UIKit

class TableViewCell2: UITableViewCell {
    
    static let cellID = "TableViewCellID2"
    
    let nameLabel = UILabel()
    let ageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .brown
        // Initialization code
    }

    private func setUI() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        nameLabel.centerX(inView: contentView)
        nameLabel.centerY(inView: contentView)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
