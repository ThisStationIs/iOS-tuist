//
//  MyCommentTableViewCell.swift
//  MyPageFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

class MyCommentTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let contentLabel = UILabel().then {
        $0.text = "내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용"
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textMain
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .textSub
    }
    
    private let writeDate = UILabel().then {
        $0.text = "23.03.09 17:37"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textAlignment = .right
        $0.textColor = .textSub
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.contentView.addSubview(containerView)
        
        [
            contentLabel,
            titleLabel,
            writeDate
        ].forEach {
            self.containerView.addSubview($0)
        }
    }
    
    private func setLayout() {
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
        
        writeDate.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.top).inset(-8)
            $0.bottom.equalTo(titleLabel.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }

}
