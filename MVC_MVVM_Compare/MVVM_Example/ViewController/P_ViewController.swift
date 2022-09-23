//
//  P_ViewController.swift
//  MVC_MVVM
//
//  Created by Hankyu Lee on 2022/09/23.
//

import Foundation
import UIKit

class P_ViewController: UIViewController {
    
    override func viewDidLoad() {
        self.viewDidLoad()
        view.backgroundColor = .red
//        view.backgroundColor = .blue
//        let button = UILabel()
//        button.text = "ewr"
////        let button = UIButton()
////        button.setTitle("버튼", for: .normal)
//        view.addSubviews(button)
//        button.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
//            make.leading.trailing.equalToSuperview().inset(20)
//        }
//        button.backgroundColor = .red
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        print("Tr")
    }
//    @objc private func didTapButton() {
//        let vc = CoursesViewController(dataFetchable: APICaller.shared)
//        present(vc, animated: true)
//    }
//
}
