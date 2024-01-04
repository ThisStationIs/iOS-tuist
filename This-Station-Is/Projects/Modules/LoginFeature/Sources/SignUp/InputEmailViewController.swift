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

import Network

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
    
    let bottomSheet = BottomSheetView(defaultHeight: 490, title: "이번 역은 서비스 약관에\n동의해주세요!")
    
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
        setBottomSheet()
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
    
    private func setBottomSheet() {
        let sheetBottomButton = Button().then {
            $0.title = "확인"
            $0.isEnabled = false
        }
        
        self.bottomSheet.updateTitleSetting(
            font: .systemFont(ofSize: 24, weight: .semibold),
            textAlignment: .left)
        
        [
            sheetBottomButton
        ].forEach {
            bottomSheet.addContentView($0)
        }
        
        sheetBottomButton.snp.updateConstraints {
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.bottom.equalToSuperview()
                .inset(40)
        }
        
        sheetBottomButton.addTarget(self, action: #selector(moveToNextPage), for: .touchUpInside)
    }
    
    @objc
    private func bottomButtonTapped() {
        guard let email = emailInputBox.textField.text else { return }
        viewModel.model.email = email
        
        
        bottomSheet.show()
//        self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        // TODO: change to coordinator
        //        delegate?.moveToNextWithEmail(model: signUpModel)
    }
    
    @objc
    private func moveToNextPage() {
        let nextVC = InputCertNumberViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension InputEmailViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
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
