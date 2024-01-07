//
//  CommentTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class CommentTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profile")
    }
    
    private let profileName = UILabel().then {
        $0.text = "행복한 바나나"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textMain
    }
    
    private let commentLabel = UILabel().then {
        $0.text = "내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
        $0.textColor = .textMain
    }
    
    private let writeDate = UILabel().then {
        $0.text = "23.03.09 17:37"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .textSub
    }
    
    private lazy var moreButton = UIButton().then {
        $0.setImage(UIImage(named: "more"), for: .normal)
        $0.addTarget(self, action: #selector(selectMoreButton), for: .touchUpInside)
    }
    
    var commentData: Comment?
    var reportHandler: ((UIAlertAction) -> Void)?
    
    public init(reuseIdentifier: String?, commentData: Comment) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        setData(commentData: commentData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectMoreButton() {
        // 내 게시글일 경우
        let userId = UserDefaults.standard.integer(forKey: "userId")
        if commentData?.userId == userId {
            let alertView = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive)
            alertView.addAction(UIAlertAction(title: "취소", style: .cancel, handler: {
                action in
                // Called when user taps outside
            }))
            alertView.addAction(deleteAction)
            
            guard let rootViewController = UIApplication.topViewController() else { return }
            rootViewController.present(alertView, animated: true)
        } else {
            let alertView = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let editAction = UIAlertAction(title: "신고하기", style: .default, handler: reportHandler)
            editAction.accessibilityValue = "\(commentData?.commentId ?? 0)"
            editAction.accessibilityLabel = "Comment"
            alertView.addAction(UIAlertAction(title: "취소", style: .cancel, handler: {
                action in
                // Called when user taps outside
            }))
            alertView.addAction(editAction)
            guard let rootViewController = UIApplication.topViewController() else { return }
            rootViewController.present(alertView, animated: true)
        }
    }
    
    private func setData(commentData: Comment) {
        /*
         "commentId": 1,
                 "nickname": "밝은고양이",
                 "content": "분실물센터 확인해보셨나요?",
                 "isReported": false,
                 "createdAt": "2023-12-27T03:42:22",
                 "lastUpdatedAt": "2023-12-27T03:42:22"
         */
        profileName.text = commentData.nickname
        commentLabel.text = commentData.content
        writeDate.text = replaceDateFormatter(date: commentData.lastUpdatedAt)
    }
    
    private func setUI() {
        self.contentView.addSubview(containerView)
        
        [
            profileImageView,
            profileName,
            commentLabel,
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
        
        profileName.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.centerY.equalTo(profileImageView)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(profileName.snp.bottom).offset(6)
            $0.leading.equalTo(profileName.snp.leading)
            $0.trailing.equalToSuperview()
        }
        
        writeDate.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(4)
            $0.leading.equalTo(profileName.snp.leading)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.bottom.equalTo(writeDate.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(12)
        }
    }
}
