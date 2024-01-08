//
//  FinishSignUpViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import SnapKit
import Then

public class FinishSignUpViewController: UIViewController {
    private let descriptionLabel = BigDescriptionLabel().then {
        $0.text = "이번 역에 도착했어요!\n내리실 문은 오른쪽입니다!"
    }
    private let correctImageView = UIImageView().then {
        $0.image = UIImage(named: "check")
    }
    private let bottomButton = Button().then {
        $0.title = "홈으로"
        $0.isEnabled = true
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation(tintColor: .textMain)
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setBinding()
    }
}

extension FinishSignUpViewController {
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
    
    private func setBinding() {
        bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func bottomButtonTapped() {
        UserDefaults.standard.setValue(true, forKey: "isLogin")
        NotificationCenter.default.post(name: NSNotification.Name("MoveToMain"), object: nil)
    }
}

