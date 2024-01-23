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
        $0.textField.keyboardType = .numberPad
    }
    private let timeLabel = UILabel().then {
        $0.text = "10:00"
        $0.textColor = .textMain
        $0.font = .systemFont(ofSize: 16)
    }
    private let sendButton = UIButton().then {
        $0.setTitle("발송", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .primaryNormal
        $0.layer.cornerRadius = 15
    }
    private let bottomButton = Button().then {
        $0.title = "다음"
        $0.isEnabled = false
    }
    
    let viewModel = SignUpViewModel.shared
    
    var timer: Timer?
    var sendEmailEncrypt: String = ""
    var seconsLeft: Int = 60*10
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        hideKeyboardWhenTappedAround()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func startTimer() {
        print("### timer")
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
                // 남은 시간에서 1초 빼기
                print("### seconsLeft is \(self.seconsLeft)")
                self.seconsLeft -= 1
                
                let minutes = self.seconsLeft/60
                let seconds = self.seconsLeft%60
                
                if self.seconsLeft > 0 {
                    self.timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
                }
                else {
                    self.timeLabel.text = "00:00"
                    t.invalidate()
                }
            }
        }
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
        bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func sendButtonClicked() {
        DispatchQueue.main.async {
            self.timer?.invalidate()
            self.timer = nil
            self.timeLabel.text = "10:00"
            self.seconsLeft = 60*10
        }
        
        self.updateButtonState(false)
        viewModel.postCertNumber(input: viewModel.model.email) { response in
            
            
            guard response.sendCount < 10 else {
                self.showAlertView(title: "인증번호 발송 횟수 초과", message: "10분 뒤 재시도해주세요.")
                return
            }
            
            self.startTimer()
            
            self.showAlertView(title: "인증메일 발송", message: "인증메일이 발송되었습니다.")
            self.sendEmailEncrypt = response.sendEmailEncrypt
        }
    }
    
    private func showAlertView(
        title: String,
        message: String
    ) {
        DispatchQueue.main.async {
            
            let alert = AlertView(title: title, message: message)
            alert.addAction(title: "확인", style: .default) {
                self.updateButtonState(true)
            }
            alert.present()
            
        }
    }
    
    func updateButtonState(_ isEnabled: Bool) {
        sendButton.backgroundColor = .primaryNormal.withAlphaComponent(isEnabled ? 1 : 0.1)
        sendButton.setTitleColor(isEnabled ? .white : .primaryNormal, for: .normal)
        sendButton.isEnabled = isEnabled
    }
    
    @objc
    func bottomButtonTapped() {
        let nextVC = InputPasswordViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension InputCertNumberViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        self.bottomButton.isEnabled = false
        self.certNumberInputBox.isError = false
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        guard text.count != 6 else {
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard text.count == 6 else { return }
        
        viewModel.postCheckCertNumber(SignUpViewModel.CheckCertNumberRequest(
            email: viewModel.model.email,
            authCode: text,
            sendEmailEncrypt: self.sendEmailEncrypt)) { res in
                guard res != "failed" else {
                    DispatchQueue.main.async {
                        self.bottomButton.isEnabled = false
                        self.certNumberInputBox.isError = true
                        self.certNumberInputBox.setErrorText("인증번호가 일치하지 않아요.")
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.bottomButton.isEnabled = true
                    self.certNumberInputBox.isError = false
                }
                self.viewModel.model.authCode = text
                self.viewModel.model.checkEmailEncrypt = res
            }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
