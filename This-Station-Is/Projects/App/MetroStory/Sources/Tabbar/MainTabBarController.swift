//
//  MainTabBarController.swift
//  MetroStory
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import BoardFeature
import HistoryFeature
import MyPageFeature

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let homeNavigationViewController = UINavigationController(rootViewController: UIViewController())
        homeNavigationViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        
        let boardNavigationViewController = UINavigationController(rootViewController: BoardViewController())
        boardNavigationViewController.tabBarItem = UITabBarItem(title: "게시판", image: UIImage(named: "board"), selectedImage: UIImage(named: "board"))
        
        let uploadViewController = BoardUploadViewController()
        uploadViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "upload_board"), tag: 2)
        
        let historyNavigationViewController = UINavigationController(rootViewController: HistoryViewController())
        historyNavigationViewController.tabBarItem = UITabBarItem(title: "내 활동", image: UIImage(named: "activity"), selectedImage: UIImage(named: "activity"))
        
        let myPageNavigationViewController = UINavigationController(rootViewController: MyPageViewController())
        myPageNavigationViewController.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "myPage"), selectedImage: UIImage(named: "myPage"))
        
        setViewControllers([homeNavigationViewController, boardNavigationViewController, uploadViewController, historyNavigationViewController, myPageNavigationViewController], animated: false)
    }
}
