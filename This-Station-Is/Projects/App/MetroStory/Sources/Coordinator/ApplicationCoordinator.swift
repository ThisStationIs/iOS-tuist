//
//  ApplicationCoordinator.swift
//  MetroStory
//
//  Created by Muzlive_Player on 2023/12/20.
//  Copyright © 2023 Muzlive. All rights reserved.
//

import UIKit
import CommonProtocol

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = rootViewController
        handleLoginStateForScreen()
        window.makeKeyAndVisible()
    }
    
    private func handleLoginStateForScreen() {
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
//        isLogin ? menuCoordinator.start() : loginCoordinator.start()
    }
}


