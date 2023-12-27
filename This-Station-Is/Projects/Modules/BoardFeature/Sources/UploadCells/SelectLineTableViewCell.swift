//
//  SelectLineTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class SelectLineTableViewCell: UITableViewCell {
    
    private lazy var selectLineView = UIButton().then {
        $0.backgroundColor = .componentTextbox
        $0.setTitle("호선을 선택해주세요.", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.layer.cornerRadius = 10
        $0.setTitleColor(.textMain, for: .normal)
        $0.addTarget(self, action: #selector(selectLine), for: .touchUpInside)
    }
    
    let lineNameArray: [String] = ["1호선", "2호선", "3호선", "4호선", "5호선", "6호선", "7호선", "8호선", "9호선", "경강선", "경의중앙선", "경춘선", "공항철도", "김포골드라인", "서해선", "수인분당선", "신림선", "신분당선", "용인에버라인", "우이신설선", "인천 1호선", "인천 2호선", "의정부경전철"]
    
    @objc func selectLine(_ sender: UIButton) {
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
       
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.contentView.addSubview(selectLineView)
        
        let actionClosure = { (action: UIAction) in
               print(action.title)
           }

           var menuChildren: [UIMenuElement] = []
           for fruit in lineNameArray {
               menuChildren.append(UIAction(title: fruit, handler: actionClosure))
           }
           
        selectLineView.menu = UIMenu(options: .displayInline, children: menuChildren)
           
        selectLineView.showsMenuAsPrimaryAction = true
        selectLineView.changesSelectionAsPrimaryAction = true
           
        selectLineView.frame = CGRect(x: 150, y: 200, width: 100, height: 40)

    }
    
    private func setLayout() {
        selectLineView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview()
        }
    }
}
