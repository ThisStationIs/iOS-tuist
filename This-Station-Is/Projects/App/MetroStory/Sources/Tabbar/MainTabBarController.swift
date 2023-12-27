//
//  MainTabBarController.swift
//  MetroStory
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import BoardFeature

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeNavigationViewController = UINavigationController(rootViewController: UIViewController())
        homeNavigationViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        
        let boardNavigationViewController = UINavigationController(rootViewController: BoardViewController())
        boardNavigationViewController.tabBarItem = UITabBarItem(title: "게시판", image: UIImage(named: "board"), selectedImage: UIImage(named: "board"))
        
        let uploadViewController = BoardUploadViewController()
        uploadViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "upload_board"), tag: 2)
        
        let historyNavigationViewController = UINavigationController(rootViewController: His)
    }
}
