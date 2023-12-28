//
//  OpenUploadViewController.swift
//  NextStationIs
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import BoardFeature

class OpenUploadViewController: UITabBarController {
    
    let boardViewModel = BoardViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let uploadViewController = UINavigationController(rootViewController: BoardUploadViewController(viewModel: boardViewModel))
        uploadViewController.modalPresentationStyle = .fullScreen
        self.present(uploadViewController, animated: true) {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
