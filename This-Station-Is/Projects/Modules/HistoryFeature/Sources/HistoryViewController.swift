//
//  HistoryViewController.swift
//  HistoryFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import SnapKit
import Then

public class HistoryViewController: UIViewController {
    private let mainTableView = UITableView().then {
        $0.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
    }
    
    private var historys: [String] = []
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setDelegate()
    }
    
    private func setNavigationBar() {
        title = "알림"
        
        let trashButton = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action: #selector(toggleEditMode))
        trashButton.tintColor = .textMain
        navigationItem.rightBarButtonItem = trashButton
    }
}

extension HistoryViewController {
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(mainTableView)
    }
    
    private func setLayout() {
        mainTableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    private func setBinding() {
        
    }
    
    @objc
    private func toggleEditMode() {
        let isEditing = !mainTableView.isEditing
        mainTableView.setEditing(!mainTableView.isEditing, animated: true)
        
        if isEditing {
            let deleteButton = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteButtonTapped))
            deleteButton.tintColor = .statusNegative
            navigationItem.rightBarButtonItem = deleteButton
        } else {
            let trashButton = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action: #selector(toggleEditMode))
            trashButton.tintColor = .textMain
            navigationItem.rightBarButtonItem = trashButton
        }
        
        for case let cell as HistoryTableViewCell in mainTableView.visibleCells {
            cell.setEditingMode(isEditing)
        }
    }
    
    @objc
    private func deleteButtonTapped() {
        let alert = AlertView(title: "해당 알림을 삭제하시겠습니까?", message: "삭제한 알림은 복구되지 않습니다.")
        alert.addAction(title: "취소", style: .cancel)
        alert.addAction(title: "삭제", style: .destructive)
        alert.present()
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historys.count == 0 ? 1 : historys.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.confgiureCell(historyCount: historys.count)
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return historys.count == 0 ? tableView.bounds.height : tableView.estimatedRowHeight
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
