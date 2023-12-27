//
//  BoardDetailContentTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class BoardDetailContentTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    
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
    
    private let commentImageView = UIImageView().then {
        $0.image = UIImage(named: "comment")
    }
    
    private let commentCountLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .textSub
    }
    
    private let underLineView = UIView().then {
        $0.backgroundColor = .componentDivider
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .textMain
    }
    
    private let contentLabel = UILabel().then {
        $0.text = " 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용"
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textMain
    }
    
    private let bottomUnderLineView = UIView().then {
        $0.backgroundColor = .componentDivider
    }
    
    init(reuseIdentifier: String?, detailData: DetailPost) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        setData(detailData: detailData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setData(detailData: DetailPost) {
        /*
         {
           "code": "200",
           "message": "OK",
           "data": {
             "postId": 1,
             "authorNickname": "밝은고양이",
             "subwayLineId": 1,
             "subwayLineName": "1호선",
             "categoryId": 1,
             "categoryName": "연착정보",
             "title": "테스트 제목이에용~",
             "content": "테스트 내용이에용!",
             "commentCount": 0,
             "likeCount": 0,
             "comments": [],
             "hasMoreComment": false,
             "lastCommentId": null,
             "createdAt": "2023-12-27T03:38:34",
             "lastUpdatedAt": "2023-12-27T03:38:34"
           }
         }
         */
        
        profileName.text = detailData.authorNickname
        lineCategoryBadge.title = detailData.subwayLineName
        cateogryBadge.title = detailData.categoryName
        titleLabel.text = detailData.title
        contentLabel.text = detailData.content
        commentCountLabel.text = "\(detailData.commentCount)"
        
    }
    
    private func setUI() {
        self.contentView.addSubview(containerView)
        
        [
            profileImageView,
            profileName,
            writeDate,
            lineCategoryBadge,
            cateogryBadge,
            commentImageView,
            commentCountLabel,
            underLineView,
            titleLabel,
            contentLabel,
            bottomUnderLineView
        ].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.top.equalToSuperview()
        }
        
        profileName.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.centerY.equalTo(profileImageView)
        }
        
        writeDate.snp.makeConstraints {
            $0.top.equalTo(profileName.snp.top)
            $0.trailing.equalToSuperview()
        }
        
        lineCategoryBadge.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
        }
        
        cateogryBadge.snp.makeConstraints {
            $0.top.equalTo(lineCategoryBadge.snp.top)
            $0.leading.equalTo(lineCategoryBadge.snp.trailing).offset(8)
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(commentImageView)
        }
        
        commentImageView.snp.makeConstraints {
            $0.trailing.equalTo(commentCountLabel.snp.leading)
            $0.width.height.equalTo(24)
            $0.top.equalTo(writeDate.snp.top).offset(22)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(lineCategoryBadge.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        bottomUnderLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.bottom.equalTo(contentLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview()
        }
    }
    
}
