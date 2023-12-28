//
//  MyCommentViewController.swift
//  MyPageFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class MyCommentViewController: UIViewController {
    
    private lazy var mainTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = 99
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    @objc func selectLeftBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        self.title = "내가 쓴 댓글"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textMain]
        self.view.backgroundColor = .white
        self.changeStatusBarBgColor(bgColor: .white)
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(selectLeftBarButton))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.view.addSubview(mainTableView)
    }
    
    private func setLayout() {
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MyCommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        }
        
        let cell = MyCommentTableViewCell.init(reuseIdentifier: identifier)
        
        return cell
    }
}
