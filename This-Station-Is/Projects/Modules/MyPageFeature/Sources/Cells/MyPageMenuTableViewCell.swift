//
//  MyPageMenuTableViewCell.swift
//  MyPageFeature
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class MyPageMenuTableViewCell: UITableViewCell {
    private let menuTitleLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .textMain
    }
    
    private let rightArrowImageView = UIImageView().then {
        $0.image = UIImage(named: "sideArrow")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle(title: String) {
        menuTitleLabel.text = title
    }
}

extension MyPageMenuTableViewCell {
    private func setUI() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        [
            menuTitleLabel, rightArrowImageView
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setLayout() {
        menuTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(8)
            $0.leading.equalToSuperview()
                .offset(24)
        }
        
        rightArrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(menuTitleLabel)
            $0.trailing.equalToSuperview()
                .inset(24)
            $0.width.height.equalTo(24)
        }
    }
}
