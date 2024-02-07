//
//  ReportCommentTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2024/01/20.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import UIKit
import UI

class ReportCommentTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profile")
    }
    
    private let reportLabel = UILabel().then {
        $0.text = "신고한 댓글입니다."
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .statusNegative
    }
    
    private let writeDate = UILabel().then {
        $0.text = "23.03.09 17:37"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .textSub
    }
    
    public init(reuseIdentifier: String?, commentData: Comment) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        setData(commentData: commentData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.contentView.addSubview(containerView)
        
        [
            profileImageView,
            reportLabel,
            writeDate
        ].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(32)
        }
        
        reportLabel.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.centerY.equalTo(profileImageView)
        }
        
        writeDate.snp.makeConstraints {
            $0.top.equalTo(reportLabel.snp.bottom).offset(4)
            $0.leading.equalTo(reportLabel.snp.leading)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.bottom.equalTo(writeDate.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setData(commentData: Comment) {
        writeDate.text = replaceDateFormatter(date: commentData.lastUpdatedAt)
    }
}
