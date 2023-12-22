//
//  CheckBox.swift
//  UI
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

public class CheckBox: UIButton {
    
    public var isCheck: Bool = false {
        didSet {
            self.setImage(isCheck ? UIImage(named: "check") : UIImage(named: "uncheck"), for: .normal)
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.frame = .init(x: 0, y: 0, width: 24, height: 24)
        self.setImage(UIImage(named: "uncheck"), for: .normal)
    }
}

