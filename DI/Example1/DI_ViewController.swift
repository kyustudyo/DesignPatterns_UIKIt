//
//  DI_ViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/23.
//

import UIKit
import SnapKit

import MyAppUIKit
import API
// API와 MyAppUIKit bridge
extension APICaller: DataFetchable { }

class DI_ViewController: UIViewController {
    
    override func viewDidLoad() {

        view.backgroundColor = .white
        let button = UIButton()
        button.setTitle("버튼", for: .normal)
        view.addSubviews(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc private func didTapButton() {
        let vc = CoursesViewController(dataFetchable: APICaller.shared)
        present(vc, animated: true)
    }
//
}
