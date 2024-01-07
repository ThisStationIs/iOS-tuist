//
//  SelectLineCollectionViewCell.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import SnapKit
import Then

import CommonProtocol

class SelectLineCollectionViewCell: UICollectionViewCell {
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectLineCollectionViewCell {
    private func setView() {
        contentView.layer.cornerRadius = 5
        contentView.addSubview(nameLabel)
    }
    
    private func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SelectLineCollectionViewCell {
    func configureCell(_ data: DataManager.Line) {
        nameLabel.text = data.name
        nameLabel.textColor = UIColor(hexCode: data.colorCode)
        nameLabel.backgroundColor = UIColor(hexCode: data.colorCode).withAlphaComponent(0.1)
    }
    
    func selectedCell(_ data: DataManager.Line) {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(hexCode: data.colorCode).cgColor
    }
    
    func unselectedCell() {
        contentView.layer.borderWidth = 0
    }
}
