//
//  BottomSheetView.swift
//  UI
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import Then

public class BottomSheetView: UIView {
    
    let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.masksToBounds = true
    }
    
    let indicatorView = UIView().then {
        $0.frame = .init(x: 0, y: 0, width: 64, height: 5)
        $0.backgroundColor = .textTeritory
        $0.layer.cornerRadius = $0.frame.height / 2
    }
    
    public let titleLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textMain
        $0.numberOfLines = 0
    }
    
    let separatorView = UIView().then {
        $0.backgroundColor = .componentDivider
    }
    
//    var contentView: UIView = UIView()
    
    var defaultHeight = (UIScreen.main.bounds.height / 844) * 214
    lazy var topConstant = self.safeAreaInsets.bottom + self.safeAreaLayoutGuide.layoutFrame.height
    
    public init(defaultHeight: CGFloat, title: String) {
        super.init(frame: .zero)
        self.defaultHeight = (UIScreen.main.bounds.height / 844) * defaultHeight
        self.titleLabel.text = title
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    public func selectSelfView() {
        guard let _ = self.superview else { return }
        self.removeFromSuperview()
    }
    
    private func setUI() {
        self.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds
            .width, height: UIScreen.main.bounds.height)
        
        self.backgroundColor = .black.withAlphaComponent(0.2)
        
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.frame
        self.addSubview(visualEffectView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectSelfView))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
        
        self.addSubview(containerView)
        
        [
            indicatorView,
            titleLabel,
            separatorView
        ].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setLayout() {
        containerView.snp.makeConstraints {
            $0.height.equalTo(defaultHeight)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(topConstant)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints {
            $0.height.equalTo(5)
            $0.width.equalTo(64)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(indicatorView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

public extension BottomSheetView {
    func show() {
        guard let rootViewController = UIApplication.topViewController() else { return }
        rootViewController.view.addSubview(self)
        
        let safeAreaHeight: CGFloat = self.safeAreaLayoutGuide.layoutFrame.height
         let bottomPadding: CGFloat = self.safeAreaInsets.bottom
        
        self.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.containerView.snp.updateConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset((safeAreaHeight + bottomPadding) - defaultHeight)
        }
        
        // TODO: 애니메이션 추가
//        UIView.animate(withDuration: 0.25, delay: 1, options: .curveEaseIn) {
//            self.layoutIfNeeded()
//        }
    }
    
    func addContentView(_ contentView: UIView) {
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func addContentViewForSignup(_ view: UIView) {
        containerView.addSubview(view)
    }
    
    func updateTitleSetting(
        font: UIFont,
        textAlignment: NSTextAlignment
    ) {
        titleLabel.font = font
        titleLabel.textAlignment = textAlignment
        
        if textAlignment == .left {
            titleLabel.snp.remakeConstraints {
                $0.top.equalTo(indicatorView.snp.bottom).offset(24)
                $0.leading.equalToSuperview()
                    .offset(24)
            }
        }
    }
}

extension BottomSheetView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.containerView) == true {
            return false
        }
        return true
    }
}
