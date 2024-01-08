//
//  InputFindEmailViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import SnapKit
import Then

import Network

public class InputFindEmailViewController: UIViewController {
    private let descriptionLabel = BigDescriptionLabel().then {
        $0.text = "회원님이 사용하시는\n아이디를 입력해주세요."
    }
    private let emailInputBox = InputBox(title: "아이디").then {
        $0.setTextFieldPlaceholder(placeholder: "이메일 형식으로 입력해주세요.")
    }
    private let bottomButton = Button().then {
        $0.title = "인증메일 발송"
        $0.isEnabled = false
    }
    
    private let viewModel = SignUpViewModel.shared
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation(tintColor: .textMain)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setDelegate()
        setBinding()
    }
}

extension InputFindEmailViewController {
    private func setView() {
        view.backgroundColor = .white
        [
            descriptionLabel,
            emailInputBox,
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
        
        emailInputBox.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
                .offset(40)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.bottom.equalToSuperview()
                .inset(24)
        }
    }
    
    private func setDelegate() {
        emailInputBox.textField.delegate = self
    }
    
    private func setBinding() {
        bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func bottomButtonTapped() {
        guard let email = emailInputBox.textField.text else { return }
        let endpoint = viewModel.postFindPassword(email: email)
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                print("### postFindPassword is successed: \(success)")
                DispatchQueue.main.async {
                    self.showToast()
                }
            case .failure(let failure):
                print("### postFindPassword is failed: \(failure)")
            }
        }
    }
    
    private func showToast() {
        let toast = Toast(type: .success)
        toast.toastText.text = "메일이 발송되었습니다."
        toast.show()
    }
}

extension InputFindEmailViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
    
        viewModel.isValidEmail(input: text) { isValid in
            switch isValid {
            case .isValid:
                self.updateInputBoxState(isEnabled: true, errorText: nil)
            case .isNotValid:
                self.updateInputBoxState(isEnabled: false, errorText: "이메일 형식이 아니에요.")
            case .isUsed:
                self.updateInputBoxState(isEnabled: false, errorText: "이미 존재하는 아이디에요.")
            }
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // TODO: util로 빼기 (InputEmailViewController랑 중복)
    private func updateInputBoxState(
        isEnabled: Bool,
        errorText: String?
    ) {
        DispatchQueue.main.async {
            self.bottomButton.isEnabled = isEnabled
            self.emailInputBox.isError = !isEnabled
            guard let errorText = errorText else { return }
            self.emailInputBox.setErrorText(errorText)
        }
    }
}
