//
//  BoardTitleTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class BoardTitleTableViewCell: UITableViewCell {

    private lazy var titleTextField = TextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요 (최대 20자)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textTeritory])
        $0.textColor = .textMain
        $0.delegate = self
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getText() -> String {
        guard let text = titleTextField.text else { return "" }
        return text
    }
    
    private func setUI() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.contentView.addSubview(titleTextField)
    }
    
    private func setLayout() {
        titleTextField.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

extension BoardTitleTableViewCell: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
