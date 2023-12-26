//
//  LoginCoordinator.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import CommonProtocol

public class LoginCoordinator: Coordinator {
//    let window: UIWindow
    
    private let presenter: UINavigationController
    private var loginViewController: LoginViewController?
    
    public init(
        presenter: UINavigationController
    ) {
        self.presenter = presenter
    }
    
    public func start() {
        let loginVC = LoginViewController()
        presenter.pushViewController(loginVC, animated: true)
    }
}
