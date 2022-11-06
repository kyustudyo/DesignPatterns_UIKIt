//
//  CustomLabel.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/10/07.
//

import UIKit
import SnapKit

class CustomView1: UIView {
//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("kk")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("rrr")
    }

    let commonButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "tray", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle))
        button.setImage(image, for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    @objc private func clickButton() {
        print("dddd")
    }
    
    private func commonInit(){
        
        
        constraintCustomView()
        
    }
    
    func constraintCustomView() {
        
//        let commonButton = UIButton(type: .system)
//        let image = UIImage(systemName: "tray", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle))
//        commonButton.setImage(image, for: .normal)
//        commonButton.tintColor = .red
//        commonButton.translatesAutoresizingMaskIntoConstraints = false
        
//        self.addSubview(titleLabel)
        
        self.addSubview(commonButton)
        commonButton.backgroundColor = .blue
        
        self.backgroundColor = .yellow
        
        commonButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        commonButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
    }

}
