//
//  CoursesViewController.swift
//  MyAppUIKit
//
//  Created by Hankyu Lee on 2022/09/23.
//

import UIKit
import SnapKit

public protocol DataFetchable {
    func fetchCourseNames(completion: @escaping ([String]) -> Void )
}

struct Course {
    let name: String
}

public class CoursesViewController: UIViewController {
    
    let dataFetchable: DataFetchable
    
    private lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.backgroundColor = .systemBackground
        dataFetchable.fetchCourseNames { [weak self] names in
            self?.courses = names.map { .init(name: $0) }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    var courses: [Course] = []
    
    //MARK: Dependency Injection
    public init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }
    
}
