//
//  Toast.swift
//  UI
//
//  Created by min on 2023/12/20.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

public class Toast: UIView {
    
    public enum ToastType {
        case success
        case error
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = AppColor.setupColor(.statusPositive)
        return imageView
    }()
    
    let toastText: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.setupColor(.textMain)
        label.text = "adsdsdsdsdsd"
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = AppColor.setupColor(.componentIcon)
        button.addTarget(self, action: #selector(selectCloseButton), for: .touchUpInside)
        return button
    }()
    
    @objc func selectCloseButton() {
        guard let root = self.superview else { return }
        self.removeFromSuperview()
    }
    
    public func show(completion: (() -> ())? = nil) {
        //TODO: 최상위 뷰 가져오기
        guard let rootViewController = UIApplication.shared.keyWindow?.visibleViewController else { return }
        rootViewController.view.addSubview(self)
        self.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        if let completion = completion {
            completion()
        }
    }
    
    public init(type: ToastType) {
        super.init(frame: .zero)
        setUI(type)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(_ type: ToastType) {
        self.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56)
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        
        self.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        switch type {
        case .success:
            self.layer.borderColor = AppColor.setupColor(.statusPositive).cgColor
            iconImageView.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = AppColor.setupColor(.statusPositive)
        case .error:
            self.layer.borderColor = AppColor.setupColor(.statusNegative).cgColor
            iconImageView.image = UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = AppColor.setupColor(.statusNegative)
        }
    }
    
    private func setLayout() {
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
        }
        
        self.addSubview(toastText)
        toastText.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
        }
        
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

extension UIWindow {
    
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(vc: self.rootViewController)
    }
    
    /**
     # visibleViewControllerFrom
     - Author: suni
     - Date:
     - Parameters:
        - vc: rootViewController 혹은 UITapViewController
     - Returns: UIViewController?
     - Note: vc내에서 가장 최상위에 있는 뷰컨트롤러 반환
    */
    public func visibleViewControllerFrom(vc: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return self.visibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return self.visibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return self.visibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}
