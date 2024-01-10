//
//  EmptyView.swift
//  MyPageFeature
//
//  Created by min on 2024/01/10.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import UIKit
import UI

class EmptyView: UIView {
    
    private let messageLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textSub
    }
    
    private var emptyMessage: String = ""
    
    init(message: String) {
        super.init(frame: .zero)
        self.emptyMessage = message
        
        setUI()
        setLayout()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setData() {
        messageLabel.text = emptyMessage
    }
    
    private func setUI() {
        self.backgroundColor = .white
        self.addSubview(messageLabel)
    }
    
    private func setLayout() {
        messageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().inset(56)
        }
    }
}
