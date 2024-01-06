//
//  CategoryView.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import CommonProtocol

public class CateogryView: UIView {
    
    private let cateogryScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    public var categoryBadgeArray: [FilterBadge] = []
    public var categoryTapGesture: ((_ badgeView: FilterBadge) -> ())!
    public var categoryArray: [DataManager.Category] = DataManager.shared.categoryInfos
    private var viewModel: BoardViewModel!
    
    @objc func selectGesuture(_ sender: UIGestureRecognizer) {
        guard let badgeView = sender.view as? FilterBadge else { return }
        // 현재 선택된 카테고리 외의 전부 삭제
        categoryBadgeArray.forEach { $0.isSelect = false }
        categoryTapGesture(badgeView)
    }
    
    public init(viewModel: BoardViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        self.addSubview(cateogryScrollView)
        
        for i in 0..<categoryArray.count {
            let badge = FilterBadge()
            badge.title = categoryArray[i].name
            badge.setType(.outline)
            badge.tag = i
            badge.isSelect = categoryArray[i].id == viewModel.selectedCategory?.id ? true : false
            
            if i == 0 && viewModel.selectedCategory?.id == 0 {
                badge.isSelect = true
                viewModel.addSelectCategory(category: "전체", tag: -1)
            }
            
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
