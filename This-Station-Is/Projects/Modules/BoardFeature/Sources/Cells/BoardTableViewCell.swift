//
//  BoardTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

public class BoardTableViewCell: UITableViewCell {
    
    private let profileView = UIView()
    
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profile")
    }
    
    private let profileName = UILabel().then {
        $0.text = "행복한 바나나"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textMain
    }
    
    private let writeDate = UILabel().then {
        $0.text = "23.03.09 17:37"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .textSub
    }
    
    public init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
    }
    
    private func setLayout() {
        self.contentView.addSubview(profileView)
    }
}
