//
//  BoardTableHeaderView.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

public class BoardTableHeaderView: UIView {
    
    private let headerLabel = UILabel().then {
        $0.text = "내 게시판"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .textMain
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
        self.backgroundColor = .white
        self.addSubview(headerLabel)
    }
    
    private func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
}
