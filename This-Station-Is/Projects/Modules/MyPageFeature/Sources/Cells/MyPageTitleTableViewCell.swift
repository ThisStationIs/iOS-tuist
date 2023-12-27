//
//  MyPageTitleTableViewCell.swift
//  MyPageFeature
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

enum MyTitleType {
    case noVersion
    case isVersion
}

class MyPageTitleTableViewCell: UITableViewCell {
    private let titleLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .textMain
    }
    
    private let versionLabel = UILabel().then {
        $0.text = "1.0.0"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textSub
    }
    
    private let borderLineView = UIView().then {
        $0.backgroundColor = .componentDivider
    }
    
    var version: MyTitleType = .noVersion
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setLayout()
    }
    
    func setupTitle(title: String) {
        titleLabel.text = title
    }
}

extension MyPageTitleTableViewCell {
    private func setUI() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        [
            titleLabel, versionLabel,
            borderLineView
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(8)
            $0.leading.equalToSuperview()
                .offset(24)
        }
        
        if version == .isVersion {
            print("### hi")
            versionLabel.snp.makeConstraints {
                $0.centerY.equalTo(titleLabel)
                $0.trailing.equalToSuperview()
                    .inset(24)
            }
        }
        
        borderLineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(8)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.height.equalTo(1)
        }
    }
}

