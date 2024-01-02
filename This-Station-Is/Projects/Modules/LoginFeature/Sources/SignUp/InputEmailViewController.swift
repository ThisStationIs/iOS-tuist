//
//  JoinViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import SnapKit
import Then

protocol InputEmailDelegate: AnyObject {
    func moveToNextWithEmail(model: SignUpModel)
}

public class InputEmailViewController: UIViewController {
    private let descriptionLabel = BigDescriptionLabel().then {
        $0.text = "로그인에 사용할 이메일 형식의\n아이디를 입력해주세요."
    }
    private let emailInputBox = InputBox(title: "이메일").then {
        $0.setTextFieldPlaceholder(placeholder: "이메일 형식으로 입력해주세요.")
    }
    private let bottomButton = Button().then {
        $0.title = "다음"
        $0.isEnabled = false
    }
    
    let viewModel = SignUpViewModel()
    
    weak var delegate: InputEmailDelegate?
    
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

extension InputEmailViewController {
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
        // TODO: change to coordinator
        //        delegate?.moveToNextWithEmail(model: signUpModel)
    }
}

extension InputEmailViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
    
        switch viewModel.isValidEmail(input: text) {
        case .isValid:
            updateInputBoxState(isEnabled: true, errorText: nil)
        case .isNotValid:
            updateInputBoxState(isEnabled: false, errorText: "이메일 형식이 아니에요.")
        case .isUsed:
            updateInputBoxState(isEnabled: false, errorText: "이미 존재하는 아이디에요.")
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
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
