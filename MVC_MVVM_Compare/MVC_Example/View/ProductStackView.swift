//
//  ProductStackView.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/22.
//

import UIKit
import SnapKit

final class ProductStackView: UIStackView {
    private lazy var accountLabel: UILabel = {
        let v = UILabel()
        v.text = "Custom TextField"
        v.font = .systemFont(ofSize: 18, weight: .bold)
        return v
    }()
    
    var type: ProductInputFieldType = .deco {
        didSet {
            setUI()
        }
    }
    
    lazy var productInputField = ProductInputTextField(frame: .zero, type: type)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
//        setUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper
extension ProductStackView {
    private func configure() {
        self.axis = .vertical
        self.spacing = 20
        self.alignment = .leading
    }
    
    private func setUI() {
        self.addArrangedSubviews(accountLabel, productInputField)
        productInputField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
}

