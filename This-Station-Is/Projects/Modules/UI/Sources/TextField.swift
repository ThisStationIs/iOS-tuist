//
//  TextField.swift
//  UI
//
//  Created by min on 2023/12/19.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import SnapKit

public class TextField: UITextField {
    let padding = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8)
    
    private lazy var underLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .componentDivider
        return lineView
    }()
    
    public init() {
        super.init(frame: .zero)
        self.addSubview(underLineView)
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

public extension TextField {
    func updateState(isError: Bool) {
        self.textColor = isError ? .statusNegative : .textMain
        self.underLineView.backgroundColor = isError ? .statusNegative : .componentDivider
    }
}
