//
//  HomeBoardCollectionViewCell.swift
//  HomeFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import Then
import SnapKit

class HomeBoardCollectionViewCell: UICollectionViewCell {
    
    private let conainerView = UIView()
    private let profileView = UIView()
    
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profile")
    }
    
    private let profileName = UILabel().then {
        $0.text = "행복한 바나나"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textMain
    }
    
    private let writeDate = UILabel().then {
        $0.text = "23.03.09 17:37"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .textSub
    }
    
    private let lineCategoryBadge = CategoryBadge().then {
        $0.title = "1호선"
        $0.setType(.background)
    }
    
    private let cateogryBadge = CategoryBadge().then {
        $0.title = "연착정보"
        $0.setType(.background)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .textMain
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용"
        $0.numberOfLines = 3
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeBoardCollectionViewCell {
    private func setView() {
        self.contentView.addSubview(conainerView)
        
        [
            profileView,
            writeDate,
            lineCategoryBadge,
            cateogryBadge,
            titleLabel,
            contentLabel,
            commentImageView,
            commentCountLabel
        ].forEach {
            conainerView.addSubview($0)
        }
        
        [
            profileImageView,
            profileName
        ].forEach {
            profileView.addSubview($0)
        }
    }
    
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.top.leading.equalToSuperview()
        }
        
        profileName.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview()
        }
        
        writeDate.snp.makeConstraints {
            $0.top.equalTo(profileName.snp.top)
            $0.trailing.equalToSuperview()
        }
        
        profileView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(profileImageView.snp.bottom)
            $0.trailing.equalTo(profileName.snp.trailing)
            
        }
        
        lineCategoryBadge.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(profileView.snp.bottom).offset(8)
        }
        
        cateogryBadge.snp.makeConstraints {
            $0.top.equalTo(lineCategoryBadge.snp.top)
            $0.leading.equalTo(lineCategoryBadge.snp.trailing).offset(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(lineCategoryBadge.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        commentImageView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(28).priority(.low)
            $0.width.height.equalTo(16)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(commentImageView)
            $0.leading.equalTo(commentImageView.snp.trailing).offset(8)
        }
        
        conainerView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.top)
            $0.bottom.equalTo(commentImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(16)
        }
    }
}
