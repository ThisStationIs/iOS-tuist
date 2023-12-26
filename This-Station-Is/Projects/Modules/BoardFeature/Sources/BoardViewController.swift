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
        $0.separatorStyle = .none
    }
    
    private let categoryView = CateogryView()
    private lazy var tableHeaderView = BoardTableHeaderView().then {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectTableHeaderView))
        $0.addGestureRecognizer(gesture)
    }
    
    private let searchBar = UISearchBar().then {
        $0.searchTextField.attributedPlaceholder = NSAttributedString(string: "찾으시는게 있나요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textSub])
        $0.searchTextField.textColor = .textMain
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    @objc func selectTableHeaderView() {
        let selectSubwayLineViewController = SelectSubwayLineViewController()
        selectSubwayLineViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(selectSubwayLineViewController, animated: true)
    }
    
    @objc func selectFilterButton() {
        // TODO: 테스트 코드
        let boardUploadViewController = BoardUploadViewController()
        boardUploadViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(boardUploadViewController, animated: true)
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationItem.titleView = searchBar
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(selectFilterButton))
        self.navigationItem.rightBarButtonItem = filterButton
        
        // TODO: 스크롤 올리면 내려오지 않음 문제 해결 필요
        self.navigationController?.hidesBarsOnSwipe = true
        
        self.view.addSubview(mainBoardTableView)
    }
    
    private func setLayout() {
        
        mainBoardTableView.snp.makeConstraints {
//            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setTableHeaderView() {
        
    }
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 + 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeaderView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row == 0 {
            let identidier = "CATEGORY_\(indexPath.row)"
            
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: identidier)
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            cell.contentView.addSubview(categoryView)
            
            return cell
        } else {
            let identifier = "LIST_\(indexPath.row)"
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            }
            
            let cell = BoardTableViewCell(reuseIdentifier: identifier)
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let boardDetailViewController = BoardDetailViewController()
        self.navigationController?.pushViewController(boardDetailViewController, animated: true)
    }
}
