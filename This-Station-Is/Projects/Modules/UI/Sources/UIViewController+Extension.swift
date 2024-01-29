//
//  UIViewController+Extension.swift
//  UI
//
//  Created by Muzlive_Player on 2024/01/02.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc open func setNavigation(
        tintColor: UIColor
    ) {
        setLeftBarButton(tintColor)
    }
    
    func setLeftBarButton(
        _ tintColor: UIColor
    ) {
        let customBackImage = UIImage(named: "arrow-up")?.withRenderingMode(.alwaysTemplate)
        
        let backButton = UIBarButtonItem(image: customBackImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = tintColor
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    open func backButtonTapped() {
        // 여기에 백 버튼을 탭했을 때의 동작을 작성하세요.
        navigationController?.popViewController(animated: true)
    }
    
    public func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard(){
        view.endEditing(true)
    }
}
