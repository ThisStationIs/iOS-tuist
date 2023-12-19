//
//  Button.swift
//  UI
//
//  Created by min on 2023/12/19.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

class Button: UIButton {
   
    override var isEnabled: Bool {
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
    
    var title: String = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    var textColor: UIColor = .white {
        didSet {
            self.setTitleColor(textColor, for: .normal)
        }
    }
   
    init() {
        super.init(frame: .zero)
        
        self.frame = .init(x: 0, y: 0, width: .zero, height: 48)
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
