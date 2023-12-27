//
//  FinishChangePasswordViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

public class FinishChangePasswordViewController: UIViewController {
    private let descriptionLabel = BigDescriptionLabel().then {
        $0.text = "비밀번호 변경이\n완료되었어요!"
        $0.textAlignment = .center
    }
    private let correctImageView = UIImageView().then {
        $0.image = UIImage(named: "check")
    }
    private let bottomButton = Button().then {
        $0.title = "로그인하기"
        $0.isEnabled = true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
    }
}

extension FinishChangePasswordViewController {
    private func setView() {
        view.backgroundColor = .white
        [
            descriptionLabel,
            correctImageView,
            bottomButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
                .offset(16)
            $0.leading.equalToSuperview()
                .offset(24)
        }
        
        correctImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(UIScreen.main.bounds.width-90)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.bottom.equalToSuperview()
                .inset(24)
        }
    }
}
