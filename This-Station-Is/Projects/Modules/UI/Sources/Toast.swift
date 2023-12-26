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
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .statusPositive
        return imageView
    }()
    
    public let toastText: UILabel = {
        let label = UILabel()
        label.textColor = .textMain
        label.text = "adsdsdsdsdsd"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .componentIcon
        button.addTarget(self, action: #selector(selectCloseButton), for: .touchUpInside)
        return button
    }()
    
    @objc func selectCloseButton() {
        guard let _ = self.superview else { return }
        self.removeFromSuperview()
    }
    
    public func show(completion: (() -> ())? = nil) {
        guard let rootViewController = UIApplication.topViewController() else { return }
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
            self.layer.borderColor = UIColor.statusPositive.cgColor
            iconImageView.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .statusPositive
        case .error:
            self.layer.borderColor = UIColor.statusNegative.cgColor
            iconImageView.image = UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .statusNegative
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

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = base as? UINavigationController {
            return topViewController(base: navigationController.visibleViewController)
        }
        
        if let tabbarController = base as? UITabBarController {
            if let selected = tabbarController.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
