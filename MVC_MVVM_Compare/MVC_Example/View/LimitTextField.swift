//
//  LimitTextField.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/22.
//

import UIKit
import SnapKit

public enum LimitTextFieldType {
//    case nickName   // 닉네임을 입력해주세요, limit : 10
    case holder     // 예금주명을 입력해주세요, limit : 20
    case account    // 계좌번호를 입력해주세요
    case check
//    case roomCode  // 정산방 코드를 입력해주세요
//    case roomName  // 정산방 이름을 입력하세요, limit : 12
    
//    case paymentTitle  // 정산하고자 하는 항목을 입력하세요, limit : 12
}

final class LimitTextField: UIView {
    private var type: LimitTextFieldType
    lazy var textField: PaddedTextField = {
        let v = PaddedTextField()
        v.clearButtonMode = .whileEditing
        v.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return v
    }()
    private lazy var line: UILabel = {
        let v = UILabel()
        v.backgroundColor = textField.text!.isEmpty ? UIColor.gray : UIColor.blue
        return v
    }()
    
    private var limit: Int?
    private var limitLabel: UILabel?
    
    init(frame: CGRect, type: LimitTextFieldType) {
        self.type = type
        super.init(frame: frame)
        configure()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper
extension LimitTextField {
    private func configure() {
        var placeholder = ""
        switch type {
        case .holder:
            placeholder = "아이디 입력하세요"
            self.limit = 20
        case .account:
            placeholder = "비밀번호를 입력하세요"
            textField.keyboardType = .decimalPad
        case .check:
            placeholder = "비밀번호를 확인하세요"
        }
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font: UIFont.systemFont(ofSize: 16)])
        
        if let limit = limit {
            limitLabel = UILabel()
            limitLabel!.text = "0/\(limit)"
            limitLabel!.textColor = .gray
            limitLabel!.font = .systemFont(ofSize: 14)
        }
    }
    
    private func setUI() {
        addSubview(textField)
        addSubview(line)
        
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        if limit != nil {
            addSubview(limitLabel!)
            limitLabel!.snp.makeConstraints { make in
                make.top.equalTo(line.snp.bottom).offset(10)
                make.trailing.equalToSuperview()
            }
        }
    }
}

// MARK: - Interaction Functions
extension LimitTextField {
    @objc private func textFieldDidChange(_ sender: UITextField) {
        line.backgroundColor = sender.text?.count == 0 ? .gray : .blue
        guard let limit = limit else { return }
        
        if (sender.text?.count)! >= limit {
            let text = textField.text!
            let index = text.index(text.startIndex, offsetBy: limit)
            let newString = text[text.startIndex..<index]
            textField.text = String(newString)
        }
        let count = (sender.text?.count)!
        limitLabel?.text = "\(count)/\(limit)"
    }
}
