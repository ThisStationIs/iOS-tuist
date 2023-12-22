//
//  BoardViewController.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UI

public class BoardViewController: UIViewController {
    
    private lazy var mainBoardTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 232
        $0.backgroundColor = .white
    }
    
    private let searchBar = UISearchBar().then {
        $0.placeholder = "찾으시는게 있나요?"
    }
    
    @objc func selectFilterButton() {
        
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationItem.titleView = searchBar
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(selectFilterButton))
        self.navigationItem.rightBarButtonItem = filterButton
        
        self.view.addSubview(mainBoardTableView)
    }
    
    private func setLayout() {
        
        mainBoardTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        }
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        
        cell.backgroundColor = .white
        
        return cell
    }
    
    
}
