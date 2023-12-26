//
//  SelectTagTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class SelectTagTableViewCell: UITableViewCell {

    private let selectTagView = UIView()
    
    private var tagButtonArray: [FilterBadge] = []
    
    let tagTitleArray: [String] = ["분실물", "연착정보", "사건사고", "알쓸신잡", "질문", "기타"]
    
    @objc func selectBadgeTapGesture(_ sender: UIGestureRecognizer) {
        guard let sender = sender.view as? FilterBadge else { return }
        tagButtonArray.forEach { $0.isSelect = false }
        sender.isSelect.toggle()
        
//        if let categorySelectAction = categorySelectAction {
//            categorySelectAction(tagTitleArray[sender.tag], sender.tag)
//        }
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
        self.contentView.addSubview(selectTagView)
        
        // tag 뷰 만들기
        for i in 0..<tagTitleArray.count {
            let badgeView = FilterBadge()
            badgeView.setType(.outline)
            badgeView.tag = i
            badgeView.title = tagTitleArray[i]
            
            let badgeTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectBadgeTapGesture))
            badgeView.addGestureRecognizer(badgeTapGesture)
            
            tagButtonArray.append(badgeView)
        }
    
        tagButtonArray.forEach { selectTagView.addSubview($0) }
    }
    
    private func setLayout() {
        selectTagView.snp.makeConstraints {
            $0.top.equalTo(tagButtonArray[0].snp.top)
            $0.bottom.equalTo(tagButtonArray[tagTitleArray.count - 1].snp.bottom)
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        // 초기 시작 위치
        var positionX = 0.0
        var positionY = 0.0
        
        for i in 0..<tagTitleArray.count {
            tagButtonArray[i].snp.makeConstraints {
                $0.left.equalTo(positionX)
                $0.top.equalTo(positionY)
            }
            
            selectTagView.layoutIfNeeded()
            
            if tagButtonArray[i].frame.maxX + 8 > UIScreen.main.bounds.width - 48 {
                positionX = 0.0
                positionY = positionY + 32 + 8
                
                tagButtonArray[i].snp.remakeConstraints {
                    $0.left.equalTo(positionX)
                    $0.top.equalTo(positionY)
                }
                
                selectTagView.layoutIfNeeded()
            }
            
            positionX = positionX + tagButtonArray[i].frame.size.width + 8
        }
    }
}
