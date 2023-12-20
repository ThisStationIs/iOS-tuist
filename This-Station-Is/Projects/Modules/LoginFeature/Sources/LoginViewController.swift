//
//  LoginViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/19.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import Then
import SnapKit

public class LoginViewController: UIViewController {
    
    let headerImage = UIImageView().then {
        $0.image = UIImage(named: "logoInLoginVC")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
    }
}

extension LoginViewController {
    private func setView() {
        view.backgroundColor = .white
        
        [
            headerImage
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        headerImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
//                .offset(56)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
