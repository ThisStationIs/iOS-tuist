//
//  MyUploadBoardTableViewCell.swift
//  MyPageFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class MyUploadBoardTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let lineCategoryBadge = CategoryBadge().then {
        $0.title = "1호선"
        $0.setType(.background)
    }
    
    private let cateogryBadge = CategoryBadge().then {
        $0.title = "연착정보"
        $0.setType(.background)
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용"
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textMain
    }
    
    private let commentImageView = UIImageView().then {
        $0.image = UIImage(named: "comment")
    }
    
    private let commentCountLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .textSub
    }
    
    private let writeDate = UILabel().then {
        $0.text = "23.03.09 17:37"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
            lineCategoryBadge,
            cateogryBadge,
            contentLabel,
            commentImageView,
            commentCountLabel,
            writeDate
        ].forEach {
            self.containerView.addSubview($0)
        }
    }
    
    private func setLayout() {
        lineCategoryBadge.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview()
        }
        
        cateogryBadge.snp.makeConstraints {
            $0.top.equalTo(lineCategoryBadge.snp.top)
            $0.leading.equalTo(lineCategoryBadge.snp.trailing).offset(8)
        }
        
        writeDate.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(lineCategoryBadge.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        commentImageView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(6)
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(commentImageView)
            $0.leading.equalTo(commentImageView.snp.trailing).offset(8)
        }
        
        self.containerView.snp.makeConstraints {
            $0.top.equalTo(lineCategoryBadge.snp.top).inset(-8)
            $0.bottom.equalTo(commentImageView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
}
