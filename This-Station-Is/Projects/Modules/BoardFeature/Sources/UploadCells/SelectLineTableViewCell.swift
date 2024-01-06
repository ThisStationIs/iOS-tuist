//
//  SelectLineTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import CommonProtocol

class SelectLineTableViewCell: UITableViewCell {
    
    private lazy var selectLineView = UIButton().then {
        $0.backgroundColor = .componentTextbox
        $0.setTitle("호선을 선택해주세요.", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.layer.cornerRadius = 10
        $0.setTitleColor(.textMain, for: .normal)
    }
    
    var viewModel: BoardViewModel!
    
    lazy var actionClosure = { (action: UIAction) in
        print(action.title)
        
        // 선택한 호선의 id 값 찾아오기
        guard let selectedLine = DataManager.shared.lineInfos.filter({ $0.name == action.title }).first else { return }
        
        self.viewModel.uploadBoardData["subwayLineId"] = selectedLine.id
    }
    
    init(reuseIdentifier: String?, viewModel: BoardViewModel) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.viewModel = viewModel
        
        // 호선 정보 가져오기
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
        
        var menuChildren: [UIMenuElement] = []
        menuChildren.append(UIAction(title: "호선을 선택해주세요.", handler: actionClosure))
        for i in 0..<DataManager.shared.lineInfos.count {
            menuChildren.append(UIAction(title: DataManager.shared.lineInfos[i].name, handler: actionClosure))
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
