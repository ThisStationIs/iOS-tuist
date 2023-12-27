//
//  BoardTableHeaderView.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

public class BoardTableHeaderView: UIView {
    
    private let headerLabel = UILabel().then {
        $0.text = "내 게시판"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .textMain
    }
    
    var dummyLine: [String] = ["1", "2", "8", "수", "인"]
    var lineIconViewArray: [UIView] = []
    
    var viewModel: BoardViewModel!
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(named: "right_arrow")
    }
    
    public init(viewModel: BoardViewModel) {
        super.init(frame: .zero)
        
        self.viewModel = viewModel
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpLineView() {
        // 상위 뷰에서 삭제 후 다시 그려주기
        lineIconViewArray.forEach { $0.removeFromSuperview() }
        lineIconViewArray = []
//        dummyPostData = postDummyData
        
        for i in 0..<viewModel.selectedLineArray.count {
            let lineView = SubwayLineView(type: .icon)
            let firstIndex = viewModel.selectedLineArray[i].name.startIndex
//            lineView.setLineName = "\(viewModel.selectedLineArray[i][firstIndex])"
            lineView.lineLabel.text = "\(viewModel.selectedLineArray[i].name[firstIndex])"
            
            lineView.setLineColor = UIColor(hexCode: viewModel.selectedLineArray[i].colorCode)
//            lineView.setLineColor = AppColor.setupLineColor(viewModel.selectedLineArray[i])
            
            lineIconViewArray.append(lineView)
        }
        
        lineIconViewArray.forEach { self.addSubview($0) }
        
        for i in 0..<lineIconViewArray.count {
            if i == 0 {
                lineIconViewArray[i].snp.makeConstraints {
                    $0.leading.equalTo(headerLabel.snp.trailing).offset(8)
                    $0.centerY.equalTo(headerLabel)
                }
            } else {
                lineIconViewArray[i].snp.makeConstraints {
                    $0.leading.equalTo(lineIconViewArray[i - 1].snp.trailing).offset(8)
                    $0.centerY.equalTo(headerLabel)
                }
            }
        }
        
//        if viewModel.selectedLineArray.count > 0 {
//            // 필터가 변경된 대로 게시글 보여주기
//            dummyPostData = dummyPostData.filter({ value in
//                viewModel.selectedLineArray.contains(value.subway)
//            })
//        }
        
//        self.boardTableView.reloadData()
    }
    
    private func setUI() {
        self.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        self.backgroundColor = .white
        self.addSubview(headerLabel)
        self.addSubview(arrowImageView)
    }
    
    private func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
}
