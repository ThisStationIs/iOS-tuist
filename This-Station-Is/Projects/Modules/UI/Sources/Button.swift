//
//  Button.swift
//  UI
//
//  Created by min on 2023/12/19.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

public class Button: UIButton {
   
    public override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = .red.withAlphaComponent(0.4)
                self.isEnabled = true
            } else {
                self.backgroundColor = .red
                self.isEnabled = false
            }
        }
    }
    
    public var title: String = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    public var textColor: UIColor = .white {
        didSet {
            self.setTitleColor(textColor, for: .normal)
        }
    }
   
    public init() {
        super.init(frame: .zero)
        self.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 48)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.backgroundColor = .red
        
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
