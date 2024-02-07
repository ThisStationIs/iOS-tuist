//
//  ReportViewController.swift
//  BoardFeature
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import Then
import UI

class ReportViewController: UIViewController {
    
    public enum ReportType: String {
        case comment = "comment"
        case post = "post"
    }
    
    private let reasonTitle = UILabel().then {
        $0.text = "신고사유"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = .componentDivider
    }
    
    private lazy var reportButton = Button().then {
        $0.title = "신고하기"
        $0.addTarget(self, action: #selector(selectReportButton), for: .touchUpInside)
    }
    
    private var reasonViewArray: [UIView] = []
    private var radioButtonArray: [RadioButton] = []
    private var postId: Int = 0
    private var reportType: ReportType = .post
    private var selectedReportReasonId: Int = 0
    private var viewModel = ReportViewModel()
    
    init(type: ReportType = .post, postId: Int) {
        super.init(nibName: nil, bundle: nil)
        self.postId = postId
        self.reportType = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getReportReasonData { [self] in
            setUI()
            setLayout()
        }
    }
    
    @objc func selectReportButton() {
        
        let alertView = AlertView(title: "신고할까요?", message: "한 번 신고가 접수되면 취소할 수 없으며,\n게시글 내용을 확인할 수 없어요.")
        alertView.addAction(title: "취소", style: .cancel)
        alertView.addAction(title: "신고", style: .destructive, handler: reportHandelr)
        alertView.present()
        
    }
    
    @objc func selectLeftBarButton() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    @objc func selectTapGesture(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        radioButtonArray.forEach { $0.isOn = false }
        radioButtonArray[view.tag].isOn.toggle()
        
        selectedReportReasonId = viewModel.reasonData[view.tag].id
    }
    
    private func reportHandelr() {
        viewModel.postReportData(type: reportType.rawValue, postId: postId, reportReasonId: selectedReportReasonId) {
            DispatchQueue.main.async {
                let alertView = AlertView(title: "신고를 접수했어요.", message: "신고하신 게시글은 게시판에서\n더 이상 확인할 수 없어요.")
                alertView.addAction(title: "확인", style: .default) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                alertView.present()
            }
        }
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.title = "신고하기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textMain]
        setupRightBarButtonItem()
        
        [
            reasonTitle,
            underlineView,
            reportButton
        ].forEach {
            self.view.addSubview($0)
        }
        
        for i in 0..<viewModel.reasonData.count {
            let reasonView = UIView()
            let titleLabel = UILabel()
            titleLabel.text = viewModel.reasonData[i].description
            reasonView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview()
            }
            
            let radioButton = RadioButton()
            radioButton.tag = i
            reasonView.addSubview(radioButton)
            radioButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
            
            reasonView.tag = i
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectTapGesture))
            reasonView.addGestureRecognizer(tapGesture)
            
            self.radioButtonArray.append(radioButton)
            self.reasonViewArray.append(reasonView)
        }
        
        reportButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setLayout() {
        reasonTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(2)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(reasonTitle.snp.bottom).offset(8)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        for i in 0..<reasonViewArray.count {
            self.view.addSubview(reasonViewArray[i])
            if i == 0 {
                reasonViewArray[i].snp.makeConstraints {
                    $0.top.equalTo(underlineView.snp.bottom).offset(4)
                    $0.height.equalTo(56)
                    $0.leading.trailing.equalToSuperview().inset(24)
                }
            } else {
                reasonViewArray[i].snp.makeConstraints {
                    $0.top.equalTo(reasonViewArray[i-1].snp.bottom).offset(8)
                    $0.height.equalTo(56)
                    $0.leading.trailing.equalToSuperview().inset(24)
                }
            }
        }
    }
    
    private func setupRightBarButtonItem() {
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(selectLeftBarButton))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
}
