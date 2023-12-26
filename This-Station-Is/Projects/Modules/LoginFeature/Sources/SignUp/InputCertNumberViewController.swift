//
//  InputCertNumberViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import SnapKit
import Then

public class InputCertNumberViewController: UIViewController {
    private let descriptionLabel = BigDescriptionLabel().then {
        $0.text = "이메일로 발송된\n인증번호 6자리를 입력해주세요."
    }
    private let certNumberInputBox = InputBox(title: "인증번호").then {
        $0.setTextFieldPlaceholder(placeholder: "인증번호 6자리")
    }
    private let timeLabel = UILabel().then {
        $0.text = "10:00"
        $0.textColor = .textMain
        $0.font = .systemFont(ofSize: 16)
    }
    private let sendButton = UIButton().then {
        $0.setTitle("발송", for: .normal)
        $0.setTitleColor(UIColor.primaryNormal, for: .normal)
        $0.backgroundColor = .primaryNormal.withAlphaComponent(0.1)
        $0.layer.cornerRadius = 15
    }
    private let bottomButton = Button().then {
        $0.title = "다음"
        $0.isEnabled = false
    }
    
    let viewModel: InputCertNumberViewModel
    var signUpModel: SignUpModel
    
    public init(model: SignUpModel) {
        self.signUpModel = model
        self.viewModel = InputCertNumberViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setDelegate()
        setBinding()
    }
}

extension InputCertNumberViewController {
    private func setView() {
        view.backgroundColor = .white
        [
            descriptionLabel,
            certNumberInputBox,
            timeLabel,
            sendButton,
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
        
        certNumberInputBox.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
                .offset(40)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(sendButton)
            $0.trailing.equalTo(sendButton.snp.leading)
                .offset(-8)
        }
        
        sendButton.snp.makeConstraints {
            $0.trailing.equalTo(certNumberInputBox)
            $0.centerY.equalTo(certNumberInputBox.textField)
            $0.width.equalTo(70)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.bottom.equalToSuperview()
                .inset(24)
        }
    }
    
    private func setDelegate() {
        certNumberInputBox.textField.delegate = self
    }
    
    private func setBinding() {
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func sendButtonClicked() {
        let alert = AlertView(title: "인증메일 발송", message: "인증메일이 발송되었습니다.")
        alert.addAction(title: "확인", style: .default)
        alert.present()
    }
}

extension InputCertNumberViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard text.count == 6 else { return }
        guard !viewModel.isValidNumber(input: text) else {
            bottomButton.isEnabled = false
            certNumberInputBox.isError = true
            certNumberInputBox.setErrorText("인증번호가 일치하지 않아요.")
            return
        }
        bottomButton.isEnabled = true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
