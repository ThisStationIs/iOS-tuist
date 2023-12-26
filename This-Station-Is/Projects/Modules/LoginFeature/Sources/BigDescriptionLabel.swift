//
//  BigDescriptionLabel.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

class BigDescriptionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = .systemFont(ofSize: 24, weight: .medium)
        self.textAlignment = .left
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LabelWithLeftImage: UIView {
    private let leftImage = UIImageView().then {
        $0.tintColor = .primaryNormal
        $0.image = UIImage(named: "passwordValid")?.withRenderingMode(.alwaysTemplate)
    }
    private let titleLabel = UILabel().then {
        $0.tintColor = .primaryNormal
        $0.font = .systemFont(ofSize: 14)
    }
    
    init(title: String) {
        titleLabel.text = title
        super.init(frame: .zero)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateState(isEnable: Bool) {
        leftImage.tintColor = isEnable ? .primaryNormal : .textSub
        titleLabel.textColor = isEnable ? .primaryNormal : .textSub
    }
}

extension LabelWithLeftImage {
    private func setView() {
        [
            leftImage,
            titleLabel
        ].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        leftImage.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(leftImage.snp.trailing)
                .offset(4)
            $0.centerY.equalTo(leftImage)
        }
    }
}


class HideButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "eye"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateIsSecureTextEntry(textField: UITextField) {
        textField.isSecureTextEntry.toggle()
        setImage(UIImage(named: textField.isSecureTextEntry ? "eye" : "eye-slash"), for: .normal)
    }
    
    
}
