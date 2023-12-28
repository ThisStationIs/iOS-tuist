//
//  MainTabBarViewController.swift
//  NextStationIs
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import SnapKit

import BoardFeature
import HistoryFeature
import MyPageFeature
import HomeFeature

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.tabBar.tintColor = .primaryNormal
        self.tabBar.unselectedItemTintColor = .textSub

        
        let homeNavigationViewController = UINavigationController(rootViewController: HomeViewController())
        homeNavigationViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 0)
        
        let boardNavigationViewController = UINavigationController(rootViewController: BoardViewController())
        boardNavigationViewController.tabBarItem = UITabBarItem(title: "게시판", image: UIImage(named: "board"), tag: 1)
        
        let uploadViewController = OpenUploadViewController()
        uploadViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "upload_board"), tag: 2)
        
        let historyNavigationViewController = UINavigationController(rootViewController: HistoryViewController())
        historyNavigationViewController.tabBarItem = UITabBarItem(title: "내 활동", image: UIImage(named: "activity"), tag: 3)
        
        let myPageNavigationViewController = UINavigationController(rootViewController: MyPageViewController())
        myPageNavigationViewController.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "myPage"), tag: 4)
        
        setViewControllers([homeNavigationViewController, boardNavigationViewController, uploadViewController, historyNavigationViewController, myPageNavigationViewController], animated: false)
        
        
    }
}
