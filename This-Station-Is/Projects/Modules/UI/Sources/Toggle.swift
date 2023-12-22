//
//  Toggle.swift
//  UI
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

public class Toggle: UISwitch {
    public init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.frame = .init(x: 0, y: 0, width: 44, height: 24)
        self.onTintColor = AppColor.setupColor(.primaryNormal)
        self.transform = .init(scaleX: 0.75, y: 0.75)
    }
}
