//
//  LoginViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/19.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import Then
import SnapKit

import UI

public class LoginViewController: UIViewController {
    private let headerImage = UIImageView().then {
        $0.image = UIImage(named: "logoInLoginVC")
    }
    private let idInputBox = InputBox(title: "아이디").then {
        $0.setTextFieldPlaceholder(placeholder: "아이디를 입력해주세요.")
    }
    private let pwInputBox = InputBox(title: "비밀번호").then {
        $0.setTextFieldPlaceholder(placeholder: "비밀번호를 입력해주세요.")
    }
    private let loginButton = Button().then {
        $0.title = "로그인"
    }
    private let buttonsStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    private let joinButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(UIColor.primaryNormal, for: .normal)
        
        $0.titleLabel?.font = .systemFont(ofSize: 14)
    }
    private let centerBarView = UIView().then {
        $0.backgroundColor = .textSub
    }
    private let findPwButton = UIButton().then {
        $0.setTitle("비밀번호찾기", for: .normal)
        $0.setTitleColor(UIColor.textSub, for: .normal)
        
        $0.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
    }
}

extension LoginViewController {
    private func setView() {
        view.backgroundColor = .white
        
        [
            headerImage,
            idInputBox,
            pwInputBox,
            loginButton,
            buttonsStack
        ].forEach {
            view.addSubview($0)
        }
        
        [
            joinButton,
            centerBarView,
            findPwButton
        ].forEach {
            buttonsStack.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        headerImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
                .offset(56)
            $0.leading.trailing.equalToSuperview()
        }
        
        idInputBox.snp.makeConstraints {
            $0.top.equalTo(headerImage.snp.bottom)
                .offset(40)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
        }
        
        pwInputBox.snp.makeConstraints {
            $0.top.equalTo(idInputBox.snp.bottom)
                .offset(40)
            $0.leading.trailing.equalTo(idInputBox)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwInputBox.snp.bottom)
                .offset(32)
            $0.leading.trailing.equalTo(idInputBox)
        }
        
        buttonsStack.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom)
                .offset(24)
            $0.centerX.equalToSuperview()
        }
        
        joinButton.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        
        centerBarView.snp.makeConstraints {
            $0.height.equalTo(11)
            $0.width.equalTo(1)
        }
        
        findPwButton.snp.makeConstraints {
            $0.width.equalTo(100)
        }
    }
}
