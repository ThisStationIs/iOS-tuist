//
//  HistoryTableViewCell.swift
//  HistoryFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

enum HistoryState {
    case noHistory
    case hasHistory
}

class HistoryTableViewCell: UITableViewCell {
    private let noHistoryDescriptionLabel = UILabel().then {
//        $0.text = "알림이 존재하지 않습니다."
        $0.text = "준비중인 서비스 입니다."
        $0.textColor = .textSub
        $0.font = .systemFont(ofSize: 16)
        $0.textAlignment = .center
    }
    // MARK: hasHistory
    private let checkboxButton = CheckBox().then {
        $0.isHidden = true
    }
    private let lineView = CategoryBadge().then {
        $0.title = "n호선"
        $0.setType(.color)
    }
    private let boardTitleLabel = UILabel().then {
        $0.text = "게시글 제목 게시글 제목 게시글 제목"
        $0.textColor = .textMain
        $0.font = .systemFont(ofSize: 14)
        $0.lineBreakMode = .byTruncatingTail
    }
    private let timeLabel = UILabel().then {
        $0.text = "오늘 17:05"
        $0.textColor = .textSub
        $0.textAlignment = .right
        $0.font = .systemFont(ofSize: 14)
    }
    private let descriptionLabel = UILabel().then {
        $0.text = "새로운 댓글이 등록되었습니다."
        $0.textColor = .textMain
        $0.font = .systemFont(ofSize: 16)
    }
    private let commentLabel = UILabel().then {
        $0.text = "댓글 내용 노출"
        $0.textColor = .textSub
        $0.font = .systemFont(ofSize: 16)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confgiureCell(historyCount: Int) {
        let hasHistoryComponents = [lineView, boardTitleLabel, timeLabel, descriptionLabel, commentLabel]
        if historyCount == 0 {
            noHistoryDescriptionLabel.isHidden = false
            hasHistoryComponents.forEach {
                $0.isHidden = true
            }
        } else {
            noHistoryDescriptionLabel.isHidden = true
            hasHistoryComponents.forEach {
                $0.isHidden = false
            }
        }
    }
    
    func setEditingMode(_ isEditing: Bool) {
        print("isEditing: \(isEditing)")
        checkboxButton.isHidden = !isEditing
    }
}

extension HistoryTableViewCell {
    private func setView() {
        [
            noHistoryDescriptionLabel,
            checkboxButton,
            lineView, boardTitleLabel, timeLabel,
            descriptionLabel,
            commentLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setLayout() {
        noHistoryDescriptionLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        checkboxButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(-20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(8)
            $0.leading.equalToSuperview()
                .offset(24)
        }
        
        boardTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(lineView)
            $0.leading.equalTo(lineView.snp.trailing)
                .offset(8)
            $0.trailing.equalTo(timeLabel.snp.leading)
                .offset(-8)
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
                .offset(-24)
            $0.centerY.equalTo(lineView)
            $0.width.equalTo(96)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
                .offset(8)
            $0.leading.equalTo(lineView)
            $0.trailing.equalTo(timeLabel)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
                .offset(8)
            $0.leading.trailing.equalTo(descriptionLabel)
        }
    }
}
