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
import Network

public class LoginViewController: UIViewController {
    private let headerImage = UIImageView().then {
        $0.image = UIImage(named: "logoInLoginVC")
    }
    private let idInputBox = InputBox(title: "아이디").then {
        $0.setTextFieldPlaceholder(placeholder: "아이디를 입력해주세요.")
    }
    private let pwInputBox = InputBox(title: "비밀번호").then {
        $0.setTextFieldPlaceholder(placeholder: "비밀번호를 입력해주세요.")
        $0.textField.isSecureTextEntry = true
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
    
    private let viewModel = LoginViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setDelegate()
        setBinding()
        
        hideKeyboardWhenTappedAround()
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
    
    private func setDelegate() {
        idInputBox.textField.delegate = self
        pwInputBox.textField.delegate = self
    }
    
    private func setBinding() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        findPwButton.addTarget(self, action: #selector(findPwButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func loginButtonTapped() {
        guard let email = idInputBox.textField.text,
              let pw = pwInputBox.textField.text else {
            print("### email or pw or both is empty")
            return
        }
        
        let endPoint = viewModel.postLogin(email: email, password: pw)
        APIServiceManager().request(with: endPoint) { result in
            switch result {
            case .success(let success):
                self.setUserData(success.data.userId, success.data.nickName, success.data.accessToken, success.data.refreshToken)
                NotificationCenter.default.post(name: NSNotification.Name("MoveToMain"), object: nil)
                UserDefaults.standard.setValue(true, forKey: "isLogin")
            case .failure(let failure):
                let alert = AlertView(title: "로그인 실패", message: "아이디 및 비밀번호가 일치하지 않아요.")
                alert.addAction(title: "확인", style: .default)
                DispatchQueue.main.async {
                    alert.present()
                }
                print("### postLogin is failed: \(failure)")
            }
        }
    }
    
    public func setUserData(
        _ userId: Int,
        _ nickName: String,
        _ at: String,
        _ rt: String
    ) {
        UserDefaults.standard.setValue(userId, forKey: "userId")
        UserDefaults.standard.setValue(nickName, forKey: "nickName")
        UserDefaults.standard.setValue(at, forKey: "accessToken")
        UserDefaults.standard.setValue(rt, forKey: "refreshToken")
    }
    
    @objc
    private func joinButtonTapped() {
        let nextVC = InputEmailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc
    private func findPwButtonTapped() {
        let nextVC = InputFindEmailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
