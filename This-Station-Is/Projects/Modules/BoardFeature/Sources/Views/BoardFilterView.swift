//
//  BoardFilterView.swift
//  BoardFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import Then
import UI

public class BoardFilterView: UIView {
    let latestView = UIView()
    let hotView = UIView()
    
    let latestLabel = UILabel().then {
        $0.text = "최신 순"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textMain
    }
    
    let hotLabel = UILabel().then {
        $0.text = "인기 많은 순"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textMain
    }
    
    let latestRadioButton = RadioButton()
    let hotRadioButton = RadioButton()
    
    
    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(latestView)
        self.addSubview(hotView)
        
        latestView.addSubview(latestLabel)
        latestView.addSubview(latestRadioButton)
        
        hotView.addSubview(hotLabel)
        hotView.addSubview(hotRadioButton)
    }
    
    private func setLayout() {
        latestView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview()
        }
        
        latestLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        latestRadioButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        hotView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(latestView.snp.bottom).offset(8)
        }
        
        hotLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        hotRadioButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
    }
}
