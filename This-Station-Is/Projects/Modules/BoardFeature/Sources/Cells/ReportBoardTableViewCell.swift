//
//  ReportBoardTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2024/01/27.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import UIKit
import UI

class ReportBoardTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let reportLabel = UILabel().then {
        $0.text = "신고한 게시글입니다."
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .statusNegative
    }
    
    private let writeDate = UILabel().then {
        $0.text = "23.03.09 17:37"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .textSub
    }
    
    let underlineView = UILabel().then {
        $0.backgroundColor = .componentDivider
    }
    
    public init(reuseIdentifier: String?, boardData: Post) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        setData(boardData: boardData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(underlineView)
        
        [
            reportLabel,
            writeDate
        ].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setLayout() {
        reportLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        writeDate.snp.makeConstraints {
            $0.centerY.equalTo(reportLabel)
            $0.trailing.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(reportLabel.snp.top)
            $0.bottom.equalTo(reportLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setData(boardData: Post) {
        writeDate.text = replaceDateFormatter(date: boardData.createdAt)
    }
}
