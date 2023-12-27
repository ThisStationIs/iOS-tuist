//
//  HomeSearchTableViewCell.swift
//  HomeFeature
//
//  Created by Muzlive_Player on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class HomeSearchTableViewCell: UITableViewCell {
    private let historyLabel = UILabel().then {
        $0.text = "line name"
        $0.textColor = .textMain
        $0.font = .systemFont(ofSize: 16)
    }
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "X"), for: .normal)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeSearchTableViewCell {
    private func setView() {
        contentView.addSubview(historyLabel)
        contentView.addSubview(deleteButton)
    }
    
    private func setLayout() {
        historyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(24)
        }
    }
}
