//
//  SelectTagTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import CommonProtocol

class SelectTagTableViewCell: UITableViewCell {

    private let selectTagView = UIView()
    
    private var tagButtonArray: [FilterBadge] = []
    
//    let tagTitleArray: [String] = ["연착정보", "분실물", "사건사고", "알쓸신잡", "질문", "기타"]
    
    var viewModel: BoardViewModel!
    
    @objc func selectBadgeTapGesture(_ sender: UIGestureRecognizer) {
        guard let sender = sender.view as? FilterBadge else { return }
        tagButtonArray.forEach { $0.isSelect = false }
        sender.isSelect.toggle()
        
        // 선택한 카테고리 저장
        self.viewModel.uploadBoardData["categoryId"] = sender.tag + 1
        
//        if let categorySelectAction = categorySelectAction {
//            categorySelectAction(tagTitleArray[sender.tag], sender.tag)
//        }
    }
    
    init(reuseIdentifier: String?, viewModel: BoardViewModel, defaultTag: String) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.viewModel = viewModel
        
        setUI(defaultTag: defaultTag)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(defaultTag: String) {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.contentView.addSubview(selectTagView)
        
        // tag 뷰 만들기
        for i in 0..<DataManager.shared.categoryInfos.count {
            let badgeView = FilterBadge()
            badgeView.setType(.outline)
            badgeView.tag = i
            badgeView.title = DataManager.shared.categoryInfos[i].name
            if defaultTag == DataManager.shared.categoryInfos[i].name {
                self.viewModel.uploadBoardData["categoryId"] = i + 1
                badgeView.isSelect = true
            }
            
            let badgeTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectBadgeTapGesture))
            badgeView.addGestureRecognizer(badgeTapGesture)
            
            tagButtonArray.append(badgeView)
        }
    
        tagButtonArray.forEach { selectTagView.addSubview($0) }
    }
    
    private func setLayout() {
        selectTagView.snp.makeConstraints {
            $0.top.equalTo(tagButtonArray[0].snp.top)
            $0.bottom.equalTo(tagButtonArray[DataManager.shared.categoryInfos.count - 1].snp.bottom)
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        // 초기 시작 위치
        var positionX = 0.0
        var positionY = 0.0
        
        for i in 0..<DataManager.shared.categoryInfos.count {
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
