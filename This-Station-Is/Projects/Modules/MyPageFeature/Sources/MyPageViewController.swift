//
//  MyPageViewController.swift
//  MyPageFeature
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

public class MyPageViewController: UIViewController {
    private let myTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    
    private let myActivityMenus: [String] = ["내 활동", "내가 쓴 글", "내가 쓴 댓글"]
    private let thisStationIsMenus: [String] = ["이번역은", "문의하기"]
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarBgColor(bgColor: .primaryNormal)
        setupNavi()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension MyPageViewController {
    private func setUI() {
        view.backgroundColor = .primaryNormal
        view.addSubview(myTableView)
        if #available(iOS 15, *) {
            myTableView.sectionHeaderTopPadding = 0
        }
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    private func setLayout() {
        myTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupNavi() {
        navigationController?.navigationBar.backgroundColor = .primaryNormal
        setupLeftBarButtonItem()
        setupRightBarButtonItem()
    }
    
    private func setupLeftBarButtonItem() {
        let leftBarItemForTitle = UIBarButtonItem(title: "나의 프로필", style: .plain, target: nil, action: nil)
        leftBarItemForTitle.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ], for: .normal)
        navigationItem.leftBarButtonItem = leftBarItemForTitle
    }
    
    private func setupRightBarButtonItem() {
        guard let originalImage = UIImage(named: "setting") else { return }
        
        let resizedImage = originalImage.resized(to: CGSize(width: 24, height: 24))
        
        let tintedImage = resizedImage?.withTintColor(.white, renderingMode: .alwaysOriginal)

        let rightBarItemForSetting = UIBarButtonItem(image: tintedImage, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarItemForSetting
    }
    
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? MyPageTableViewHeader() : nil
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 88 : 40
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        }
        
        switch indexPath.row {
        case 0:
            let cell = MyPageTitleTableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.setupTitle(title: section == 0 ? myActivityMenus[0] : thisStationIsMenus[0])
            cell.version = section == 0 ? .noVersion : .isVersion
            return cell
        default:
            let cell = MyPageMenuTableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.setupTitle(title: section == 0 ? myActivityMenus[row] : thisStationIsMenus[row])
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? myActivityMenus.count : thisStationIsMenus.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        return row == 0 ? 45 : 40
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let myUploadBoardViewController = MyUploadBoardViewController()
            myUploadBoardViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(myUploadBoardViewController, animated: true)
        } else if indexPath.section == 0 && indexPath.row == 2 {
            let myCommentViewController = MyCommentViewController()
            myCommentViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(myCommentViewController, animated: true)
        }
    }
    
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
         UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
         self.draw(in: CGRect(origin: .zero, size: size))
         let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return resizedImage
     }
}
