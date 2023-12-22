//
//  CategoryView.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

public class CateogryView: UIView {
    
    private let cateogryScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let cateogryArray: [String] = ["전체", "연착정보", "분실물", "사건사고", "알쓸신잡"]
    private var categoryBadgeArray: [FilterBadge] = []
    
    @objc func selectGesuture() {
        
    }
    
    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        self.addSubview(cateogryScrollView)
        
        for i in 0..<cateogryArray.count {
            let badge = FilterBadge()
            badge.title = cateogryArray[i]
            badge.setType(.outline)
            badge.tag = i
            let gesture = UITapGestureRecognizer(target: self, action: #selector(selectGesuture))
            badge.addGestureRecognizer(gesture)
            
            categoryBadgeArray.append(badge)
        }
        
        categoryBadgeArray.forEach { cateogryScrollView.addSubview($0) }
    }
    
    private func setLayout() {
        for i in 0..<categoryBadgeArray.count {
            if i == 0 {
                categoryBadgeArray[i].snp.makeConstraints {
                    $0.top.equalToSuperview()
                    $0.leading.equalToSuperview().inset(24)
                }
            } else if i == categoryBadgeArray.count - 1 {
                categoryBadgeArray[i].snp.makeConstraints {
                    $0.top.equalToSuperview()
                    $0.leading.equalTo(categoryBadgeArray[i - 1].snp.trailing).offset(8)
                    $0.trailing.equalToSuperview().inset(24)
                }
            } else {
                categoryBadgeArray[i].snp.makeConstraints {
                    $0.top.equalToSuperview()
                    $0.leading.equalTo(categoryBadgeArray[i - 1].snp.trailing).offset(8)
                }
            }
        }
        
        cateogryScrollView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.edges.equalToSuperview()
        }
    }
}
