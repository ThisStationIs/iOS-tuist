//
//  DropDown.swift
//  UI
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

public class DropDown: UIView {
    
    let lineNameArray: [String] = ["1호선", "2호선", "3호선", "4호선", "5호선", "6호선", "7호선", "8호선", "9호선", "경강선", "경의중앙선", "경춘선", "공항철도", "김포골드라인", "서해선", "수인분당선", "신림선", "신분당선", "용인에버라인", "우이신설선", "인천 1호선", "인천 2호선", "의정부경전철"]
    
    public init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
    }
    
    private func setLayout() {
        
    }
}
