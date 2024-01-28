//
//  UnregisterViewController.swift
//  MyPageFeature
//
//  Created by min on 2024/01/10.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import UIKit
import UI

class UnregisterViewController: UIViewController {
    
    private let titleLabel = UILabel().then {
        $0.text = "탈퇴 전 확인해주세요."
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "회원을 탈퇴하시면 이용중인 서비스를 사용하실 수 없으며, 모든 데이터는 복구가 불가능합니다."
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)

    }
    
    private lazy var passwordTextField = InputBox(title: "비밀번호").then {
        $0.setTextFieldPlaceholder(placeholder: "비밀번호를 입력해주세요.")
        $0.textField.isSecureTextEntry = true
        $0.textField.delegate = self
    }
    
    private lazy var unregisterButton = Button().then {
        $0.title = "탈퇴하기"
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(selectUnregisterButton), for: .touchUpInside)
    }
    
    private lazy var checkBox = CheckBox().then {
        $0.addTarget(self, action: #selector(selectCheckBox), for: .touchUpInside)
    }
    private let checkBoxLabel = UILabel().then {
        $0.text = "안내사항을 확인했으며, 이에 동의합니다."
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    private var viewModel: MyPageViewModel!
    
    init(viewModel: MyPageViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "회원탈퇴"
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(selectLeftBarButton))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    @objc func selectLeftBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectCheckBox(_ sender: CheckBox) {
        sender.isCheck.toggle()
        guard let text = passwordTextField.textField.text else { return }
        if !text.isEmpty {
            unregisterButton.isEnabled = sender.isCheck ? true : false
        }
    }
    
    @objc func selectUnregisterButton() {
        passwordTextField.textField.endEditing(true)
        guard let text = passwordTextField.textField.text else { return }
        viewModel.deleteUnregisterData(password: text) { returnType in
            if returnType == .success {
                // 회원탈퇴 완료
                let alert = AlertView(title: "회원탈퇴가 완료되었습니다.", message: "이용해주셔서 감사합니다.")
                alert.addAction(title: "확인", style: .default) {
                    NotificationCenter.default.post(name: NSNotification.Name("MoveToLogin"), object: nil)
                }
                alert.present()
            } else {
                let toast = Toast(type: .error)
                toast.toastText.text = "비밀번호를 다시 한번 확인해주세요."
                toast.show()
            }
        }
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        
        [
            titleLabel,
            descriptionLabel,
            passwordTextField,
            checkBox,
            checkBoxLabel,
            unregisterButton
        ].forEach {
            self.view.addSubview($0)
        }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        unregisterButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        checkBox.snp.makeConstraints {
            $0.bottom.equalTo(unregisterButton.snp.top).inset(-24)
            $0.leading.equalToSuperview().inset(24)
        }
        
        checkBoxLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkBox)
            $0.leading.equalTo(checkBox.snp.trailing).offset(8)
        }
    }
}

extension UnregisterViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if checkBox.isCheck {
            unregisterButton.isEnabled = string.isEmpty ? false : true
        }
        return true
    }
}
