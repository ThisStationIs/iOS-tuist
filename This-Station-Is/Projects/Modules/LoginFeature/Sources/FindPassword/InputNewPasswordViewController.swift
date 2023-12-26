//
//  InputNewPasswordViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

// TODO: 중복코드 제거
public class InputNewPasswordViewController: UIViewController {
    private let descriptionLabel = BigDescriptionLabel().then {
        $0.text = "새롭게 사용하실\n비밀번호를 입력해주세요."
    }
    private let passwordInputBox = InputBox(title: "새로운 비밀번호").then {
        $0.setTextFieldPlaceholder(placeholder: "비밀번호를 입력해주세요.")
        $0.textField.isSecureTextEntry = true
    }
    private let passwordInputBoxHideButton = HideButton()
    private let englishLabelWithLeftImage = LabelWithLeftImage(title: "영문 대/소문자").then {
        $0.updateState(isEnable: false)
    }
    private let countLabelWithLeftImage = LabelWithLeftImage(title: "8 ~ 16자리").then {
        $0.updateState(isEnable: false)
    }
    private let passwordReInputBox = InputBox(title: "비밀번호 확인").then {
        $0.setTextFieldPlaceholder(placeholder: "비밀번호를 다시 입력해주세요.")
        $0.textField.isSecureTextEntry = true
    }
    private let passwordReInputBoxHideButton = HideButton()
    private let correctLabelWithLeftImage = LabelWithLeftImage(title: "일치").then {
        $0.updateState(isEnable: false)
    }
    private let bottomButton = Button().then {
        $0.title = "다음"
        $0.isEnabled = false
    }
    
    let viewModel = InputPasswordViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setDelegate()
        setBinding()
    }
}

extension InputNewPasswordViewController {
    private func setView() {
        view.backgroundColor = .white
        [
            descriptionLabel,
            passwordInputBox, passwordInputBoxHideButton,
            englishLabelWithLeftImage, countLabelWithLeftImage,
            passwordReInputBox, passwordReInputBoxHideButton,
            correctLabelWithLeftImage,
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
        
        passwordInputBox.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
                .offset(40)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
        }
        
        passwordInputBoxHideButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordInputBox)
            $0.trailing.equalTo(passwordInputBox)
            $0.width.height.equalTo(24)
        }
        
        englishLabelWithLeftImage.snp.makeConstraints {
            $0.top.equalTo(passwordInputBox.snp.bottom)
                .offset(4)
            $0.leading.equalTo(passwordInputBox)
            $0.width.equalTo(106)
        }
        
        countLabelWithLeftImage.snp.makeConstraints {
            $0.centerY.equalTo(englishLabelWithLeftImage)
            $0.leading.equalTo(englishLabelWithLeftImage.snp.trailing)
                .offset(16)
        }
        
        passwordReInputBox.snp.makeConstraints {
            $0.top.equalTo(englishLabelWithLeftImage.snp.bottom)
                .offset(40)
            $0.leading.trailing.equalTo(passwordInputBox)
        }
        
        passwordReInputBoxHideButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordReInputBox)
            $0.trailing.equalTo(passwordReInputBox)
            $0.width.height.equalTo(24)
        }
        
        correctLabelWithLeftImage.snp.makeConstraints {
            $0.top.equalTo(passwordReInputBox.snp.bottom)
                .offset(4)
            $0.leading.equalTo(passwordReInputBox)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.bottom.equalToSuperview()
                .inset(24)
        }
    }
    
    private func setDelegate() {
        passwordInputBox.textField.delegate = self
        passwordReInputBox.textField.delegate = self
    }
    
    private func setBinding() {
        passwordInputBoxHideButton.addTarget(self, action: #selector(passwordInputBoxHideButtonTapped), for: .touchUpInside)
        passwordReInputBoxHideButton.addTarget(self, action: #selector(passwordReInputBoxHideButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func passwordInputBoxHideButtonTapped() {
        passwordInputBoxHideButton.updateIsSecureTextEntry(textField: passwordInputBox.textField)
    }
    
    @objc
    private func passwordReInputBoxHideButtonTapped() {
        passwordReInputBoxHideButton.updateIsSecureTextEntry(textField: passwordReInputBox.textField)
    }
}

extension InputNewPasswordViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordInputBox.textField {
            guard let text = textField.text else { return }
            englishLabelWithLeftImage.updateState(isEnable: viewModel.isValidEnglish(input: text))
            countLabelWithLeftImage.updateState(isEnable: viewModel.isValidCount(input: text))
        }
        
        correctLabelWithLeftImage.updateState(isEnable: viewModel.isCorrect(
            firstInput: passwordInputBox.textField.text ?? "", secondInput: passwordReInputBox.textField.text ?? "") ? true : false)
        bottomButton.isEnabled = viewModel.isValidCount == 3 ? true : false
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
