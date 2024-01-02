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
        let toast = Toast(type: .success)
        toast.toastText.text = "메일이 발송되었습니다."
        toast.show()
    }
}

extension InputFindEmailViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let viewModel = SignUpViewModel()
        guard let text = textField.text else { return }
    
        switch viewModel.isValidEmail(input: text) {
        case .isValid, .isUsed:
            updateInputBoxState(isEnabled: true, errorText: nil)
        case .isNotValid:
            updateInputBoxState(isEnabled: false, errorText: "이메일 형식이 아니에요.")
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
        bottomButton.isEnabled = isEnabled
        emailInputBox.isError = !isEnabled
        guard let errorText = errorText else { return }
        emailInputBox.setErrorText(errorText)
    }
}
