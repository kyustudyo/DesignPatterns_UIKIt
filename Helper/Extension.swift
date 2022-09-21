//
//  Extension.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/21.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ subviews: UIView...) {
    for subview in subviews {
      addArrangedSubview(subview)
    }
  }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
