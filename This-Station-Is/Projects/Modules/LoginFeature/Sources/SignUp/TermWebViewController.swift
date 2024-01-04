//
//  TermWebViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2024/01/04.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import UIKit
import WebKit

class TermWebViewController: UIViewController {
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.backgroundColor = UIColor.white
        webView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setWebView(_ url: String) {
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }
}
