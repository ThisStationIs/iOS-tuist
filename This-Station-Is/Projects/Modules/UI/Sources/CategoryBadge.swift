//
//  CategoryBadge.swift
//  UI
//
//  Created by min on 2023/12/20.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

public class CategoryBadge: UIView {
    
    public enum BadgeType {
        case outline
        case color
        case background
    }
    
    let badgeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    public var title: String = "" {
        didSet {
            badgeTitleLabel.text = title
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setType(_ type: BadgeType = .outline) {
        self.layer.borderWidth = 1
        self.backgroundColor = .white
        
        switch type {
        case .outline:
            badgeTitleLabel.textColor = AppColor.setupColor(.textTeritory)
            self.layer.borderColor = AppColor.setupColor(.componentDivider).cgColor
        case .color:
            self.layer.borderColor = AppColor.setupColor(.primaryNormal).cgColor
            badgeTitleLabel.textColor = AppColor.setupColor(.primaryNormal)
        case .background:
            badgeTitleLabel.textColor = AppColor.setupColor(.textSub)
            self.backgroundColor = AppColor.setupColor(.componentTextbox)
            self.layer.borderColor = AppColor.setupColor(.componentDivider).cgColor
        }
    }
    
    private func setUI() {
        self.frame = .init(x: 0, y: 0, width: 54, height: 24)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        setType()
    }
    
    private func setLayout() {
        self.addSubview(badgeTitleLabel)
        badgeTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        self.snp.makeConstraints {
            $0.top.equalTo(badgeTitleLabel.snp.top).inset(4)
            $0.bottom.equalTo(badgeTitleLabel.snp.bottom).inset(-4)
            $0.leading.equalTo(badgeTitleLabel.snp.leading).inset(12)
            $0.trailing.equalTo(badgeTitleLabel.snp.trailing).inset(-12)
        }
    }
}

