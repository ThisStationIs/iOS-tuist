//
//  JoinViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import WebKit

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
//        $0.isEnabled = false
    }
    
    let allAgreementButton = UIButton().then {
        $0.setImage(UIImage(named: "uncheck"), for: .normal)
        $0.setTitle("  전체동의", for: .normal)
        $0.setTitleColor(UIColor.textMain, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
    let firstTermView = TermsAgreementView().then {
        $0.setTitle(title: "이용약관 동의")
    }
    let secondTermView = TermsAgreementView().then {
        $0.setTitle(title: "개인정보 수집 및 동의")
    }
    let sheetBottomButton = Button().then {
        $0.title = "확인"
        $0.isEnabled = false
    }
    
    let bottomSheet = BottomSheetView(defaultHeight: 394, title: "이번 역은 서비스 약관에\n동의해주세요!")
    var isRequiredCount: Int = 0 {
        didSet {
            updateTermButtons()
        }
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
        
        
        self.bottomSheet.updateTitleSetting(
            font: .systemFont(ofSize: 24, weight: .semibold),
            textAlignment: .left)
        
        [
            allAgreementButton,
            firstTermView,
            secondTermView,
            sheetBottomButton
        ].forEach {
            bottomSheet.addContentViewForSignup($0)
        }
        
        allAgreementButton.snp.makeConstraints {
            $0.top.equalTo(bottomSheet.titleLabel.snp.bottom)
                .offset(24)
            $0.leading.equalToSuperview()
                .offset(24)
            $0.height.equalTo(24)
        }

        firstTermView.snp.makeConstraints {
            $0.top.equalTo(allAgreementButton.snp.bottom)
                .offset(49)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.height.equalTo(24)
        }

        secondTermView.snp.makeConstraints {
            $0.top.equalTo(firstTermView.snp.bottom)
                .offset(24)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.height.equalTo(24)
        }

        sheetBottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.bottom.equalToSuperview()
                .inset(40)
            $0.height.equalTo(48)
        }
        
        allAgreementButton.addTarget(self, action: #selector(allAgreementButtonTapped), for: .touchUpInside)
        firstTermView.checkButton.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        firstTermView.arrowButton.addTarget(self, action: #selector(firstArrowButtonTapped), for: .touchUpInside)
        secondTermView.checkButton.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        secondTermView.arrowButton.addTarget(self, action: #selector(secondArrowButtonTapped), for: .touchUpInside)
        sheetBottomButton.addTarget(self, action: #selector(moveToNextPage), for: .touchUpInside)
        
    }
    
    @objc
    private func bottomButtonTapped() {
        guard let email = emailInputBox.textField.text else { return }
        viewModel.model.email = email
        
        bottomSheet.show()
        // TODO: change to coordinator
        //        delegate?.moveToNextWithEmail(model: signUpModel)
    }
    
    
    @objc
    private func allAgreementButtonTapped() {
        allAgreementButton.isSelected.toggle()
        isRequiredCount = allAgreementButton.isSelected ? 2 : 0
    }
    
    @objc
    private func checkBoxTapped(_ sender: CheckBox) {
        sender.isCheck.toggle()
        if sender.isCheck { isRequiredCount += 1 }
        else {
            guard isRequiredCount > 0 else { return }
            isRequiredCount -= 1
        }
    }
    
    @objc
    private func firstArrowButtonTapped(_ sender: UIButton) {
        let webVC = TermWebViewController()
        viewModel.getTerms("TERMS01") { url in
            webVC.setWebView(url)
        }
        self.present(webVC, animated: true)
    }
    
    @objc
    private func secondArrowButtonTapped(_ sender: UIButton) {
        let webVC = TermWebViewController()
        viewModel.getTerms("TERMS02") { url in
            webVC.setWebView(url)
        }
        self.present(webVC, animated: true)
    }
    
    @objc
    private func moveToNextPage() {
        viewModel.model.termsAgreementRequestList = [
            TermsAgreementRequest(terms: "TERMS01", agreed: true),
            TermsAgreementRequest(terms: "TERMS02", agreed: true)
        ]
        
        let nextVC = InputCertNumberViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        bottomSheet.selectSelfView()
    }
    
    func updateTermButtons() {
        allAgreementButton.isSelected = isRequiredCount == 2 ? true : false
        allAgreementButton.setImage(UIImage(named: isRequiredCount == 2 ? "check" : "uncheck"), for: .normal)

        if isRequiredCount == 0 {
            [
                firstTermView,
                secondTermView
            ].forEach {
                $0.checkButton.isCheck = false
            }
        } else if isRequiredCount == 2 {
            [
                firstTermView,
                secondTermView
            ].forEach {
                $0.checkButton.isCheck = true
            }
        }
        
        sheetBottomButton.isEnabled = isRequiredCount == 2 ? true : false
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

class TermsAgreementView: UIView {
    let checkButton = CheckBox()
    
    let badge = CategoryBadge().then {
        $0.title = "필수"
        $0.badgeTitleLabel.textColor = .primaryNormal
        $0.backgroundColor = .primaryNormal.withAlphaComponent(0.1)
    }
    
    let title = UILabel().then {
        $0.textColor = .textMain
        $0.font = .systemFont(ofSize: 14)
    }
    
    let arrowButton = UIButton().then {
        $0.setImage(UIImage(named: "arrowRight"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        [
            checkButton,
            badge,
            title,
            arrowButton
        ].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        checkButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        badge.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkButton.snp.trailing)
                .offset(8)
        }
        
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(badge.snp.trailing)
                .offset(8)
        }
        
        arrowButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(24)
        }
    }
    
    func setTitle(title: String) {
        self.title.text = title
    }
}
