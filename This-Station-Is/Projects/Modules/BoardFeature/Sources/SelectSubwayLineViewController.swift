//
//  SelectSubwayLineViewController.swift
//  BoardFeature
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import CommonProtocol

class SelectSubwayLineViewController: UIViewController {
    
    let titleLabel = UILabel().then {
        $0.text = "지하철 호선 선택"
        $0.textColor = .textMain
    }
    
    let separatorView = UIView().then {
        $0.backgroundColor = .componentDivider
    }
    
    let lineContentView = UIView().then {
        $0.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height)
    }
    
    lazy var applyButton = Button().then {
        $0.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 60)
        $0.setTitle("적용", for: .normal)
        $0.addTarget(self, action: #selector(selectApplyButton), for: .touchUpInside)
    }
    
    private var viewModel: BoardViewModel!
    private var lineNameViewArray: [UIButton] = []
    private var savedLineArray: [DataManager.Line] = []
    
    init(viewModel: BoardViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.savedLineArray = viewModel.selectedLineArray
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hidesBarsOnSwipe = false
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(selectLeftBarButton))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // 호선 정보 가져오기
        self.setUI()
        self.setLayout()
    }
    
    @objc func selectLeftBarButton() {
        // 적용 버튼을 누르지 않으면 초기화
        self.viewModel.selectedLineArray = self.savedLineArray
        lineNameViewArray = []
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectLineButton(_ sender: UIButton) {
        print(sender.isSelected)
        sender.isSelected.toggle()
       
        // 호선 저장
        sender.isSelected ?
        viewModel?.addSelectLine(lineInfo: DataManager.shared.lineInfos[sender.tag], tag: sender.tag) :
        viewModel?.removeSelectLine(lineInfo: DataManager.shared.lineInfos[sender.tag], tag: sender.tag)
        
        // 선택된 호선이 5개 이상이면
        if !viewModel.canSelect {
            sender.isSelected = false
            
            // 토스트 띄우기
            let toast = Toast(type: .error)
            toast.toastText.text = "최대 5개까지만 선택할 수 있어요."
            toast.show()
            
            return
        }
        
        lineNameViewArray[sender.tag].backgroundColor = sender.isSelected ? UIColor(hexCode: DataManager.shared.lineInfos[sender.tag].colorCode, alpha: 0.1) : .white
        lineNameViewArray[sender.tag].layer.borderWidth = sender.isSelected ? 0 : 1
        
        let titleLabel = lineNameViewArray[sender.tag].subviews[0] as! UILabel
        titleLabel.textColor = sender.isSelected ? UIColor(hexCode: DataManager.shared.lineInfos[sender.tag].colorCode) : .textTeritory
    }
    
    @objc func selectApplyButton() {
        // 호선 정보 저장된 게시글 목록 불러오기
        
        // 적용 버튼
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        
        [
            titleLabel,
            separatorView,
            lineContentView,
            applyButton,
        ].forEach {
            self.view.addSubview($0)
        }
        
        // 호선 뷰 만들기
        for i in 0..<DataManager.shared.lineInfos.count {
            let lineButton = UIButton()
            lineButton.layer.cornerRadius = 32 / 2
            lineButton.layer.masksToBounds = true
            lineButton.layer.borderWidth = 1
            lineButton.layer.borderColor = UIColor.textTeritory.cgColor
            lineButton.tag = i
            lineButton.addTarget(self, action: #selector(selectLineButton), for: .touchUpInside)
            
            let lineLabel = UILabel()
            lineLabel.text = DataManager.shared.lineInfos[i].name
            lineLabel.textColor = .textTeritory
            lineLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            lineButton.addSubview(lineLabel)
            lineLabel.snp.makeConstraints {
                $0.top.bottom.equalToSuperview().inset(8)
                $0.leading.trailing.equalToSuperview().inset(12)
            }

            lineButton.snp.makeConstraints {
                $0.top.equalTo(lineLabel.snp.top).inset(-8)
                $0.bottom.equalTo(lineLabel.snp.bottom).inset(-8)
                $0.leading.equalTo(lineLabel.snp.leading).inset(-12)
                $0.trailing.equalTo(lineLabel.snp.trailing).inset(-12)
            }
            
            // 현재 선택되어있는 호선 표시
            for j in 0..<viewModel.selectedLineArray.count {
                // id가 같으면 선택 처리
                if viewModel.selectedLineArray[j].id == DataManager.shared.lineInfos[i].id {
                    lineButton.isSelected = true
                    // 배경 색, 텍스트 색 변경
                    lineLabel.textColor = UIColor(hexCode: DataManager.shared.lineInfos[i].colorCode)
                    lineButton.backgroundColor = UIColor(hexCode: DataManager.shared.lineInfos[i].colorCode, alpha: 0.1)
                    
                    lineButton.layer.borderWidth = 0
                }
            }
            
            lineNameViewArray.append(lineButton)
    
        }
        
        lineNameViewArray.forEach { lineContentView.addSubview($0) }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        lineContentView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        // 호선 명 레이아웃 설정
        
        // 초기 시작 위치
        var positionX = 24.0
        var positionY = 20.0
        
        for i in 0..<lineNameViewArray.count {
            lineNameViewArray[i].snp.makeConstraints {
                $0.left.equalTo(positionX)
                $0.top.equalTo(positionY)
                $0.height.equalTo(32)
            }
            
            lineContentView.layoutIfNeeded()
            
            if lineNameViewArray[i].frame.maxX + 16 > UIScreen.main.bounds.width {
                positionX = 24.0
                positionY = positionY + 32 + 16
                
                lineNameViewArray[i].snp.remakeConstraints {
                    $0.left.equalTo(positionX)
                    $0.top.equalTo(positionY)
                    $0.height.equalTo(32)
                }
                
                lineContentView.layoutIfNeeded()
            }
            
            positionX = positionX + lineNameViewArray[i].frame.size.width + 16
        }
        
        applyButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
    }
}

