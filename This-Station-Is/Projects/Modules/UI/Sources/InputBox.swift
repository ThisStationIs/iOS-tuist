//
//  InputBox.swift
//  UI
//
//  Created by min on 2023/12/19.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import SnapKit

class InputBox: UIView {
    
    private let textField: TextField = {
       let textField = TextField()
        return textField
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let errorText: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(errorText)
        errorText.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).inset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top).offset(8)
            $0.bottom.equalTo(errorText.snp.bottom)
        }
    }
}
