//
//  SubwayLineView.swift
//  UI
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

public class SubwayLineView: UIView {
    
    public enum LineViewType {
        case icon
        case `default`
    }
    
    let circleView = UIView().then {
        $0.frame = .init(x: 0, y: 0, width: 20, height: 20)
        $0.backgroundColor = .systemBlue
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = $0.layer.frame.width / 2
    }
    
    public let lineLabel = UILabel().then {
        $0.text = "7"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .white
    }
    
    let stationLabel = UILabel().then {
        $0.text = "양재시민의숲역"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    var type: LineViewType = .default
    
    var setLineName: String = "" {
        didSet {
            lineLabel.text = setLineName
        }
    }
    
    var setLineColor: UIColor = .red {
        didSet {
            circleView.backgroundColor = setLineColor
        }
    }
    
    
    /// 호선 표시
    /// - Parameter type: icon = 호선만 표시, default = 호선과 역명 표시
    public init(type: LineViewType = .default) {
        super.init(frame: .zero)
        
        self.type = type
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        
        switch type {
        case .default:
            // 호선과 역명 둘 다 표시
            self.backgroundColor = .componentTextbox
            self.layer.cornerRadius = 38 / 2
            
            [
                circleView,
                stationLabel
            ].forEach {
                self.addSubview($0)
            }
            
            circleView.addSubview(lineLabel)
        case .icon:
            // 호선만 표시
            self.backgroundColor = .clear
            
            self.addSubview(circleView)
            circleView.addSubview(lineLabel)
        }
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        
        circleView.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(type == .default ? 12 : 0)
        }
        
        circleView.layer.cornerRadius = 20 / 2
        
        lineLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        switch type {
        case .default:
            stationLabel.snp.makeConstraints {
                $0.centerY.equalTo(circleView)
                $0.leading.equalTo(circleView.snp.trailing).offset(8)
                $0.trailing.equalToSuperview().inset(12)
            }
            
            self.snp.makeConstraints {
                $0.height.equalTo(38)
                $0.leading.equalTo(circleView.snp.leading).inset(-12)
                $0.trailing.equalTo(stationLabel.snp.trailing).inset(-12)
            }
        case .icon:
            self.snp.makeConstraints {
                $0.height.equalTo(38)
                $0.leading.equalTo(circleView.snp.leading)
                $0.trailing.equalTo(circleView.snp.trailing)
            }
        }
    }
}


