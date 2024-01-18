//
//  MyPageViewController.swift
//  MyPageFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

public class MyPageViewController: UIViewController {
    
    private let profileView = UIView().then {
        $0.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 154)
        $0.backgroundColor = .primaryNormal
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "나의 프로필"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.textColor = .white
    }
    
    private lazy var settingButton = UIButton().then {
        $0.setImage(UIImage(named: "setting"), for: .normal)
        $0.addTarget(self, action: #selector(selectSettingButton), for: .touchUpInside)
    }
    
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "my_profile")
    }
    
    private let profileNameLabel = UILabel().then {
        $0.text = "행복한 바나나"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .white
    }
    
    private let profileUIDLabel = UILabel().then {
        $0.text = "UID 123"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .white
    }
    
    private lazy var myTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    
    var stringArray: [String] = ["내가 쓴 글", "내가 쓴 댓글"]
    
    private let viewModel = MyPageViewModel()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        print("🍅 ACCESS_TOKEN : \(viewModel.ACCESS_TOKEN)")
        setUI()
        setLayout()
        setData()
    }
    
    @objc func selectSettingButton() {
        let settingViewController = SettingViewController(viewModel: viewModel)
        settingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    private func setData() {
        profileNameLabel.text = UserDefaults.standard.string(forKey: "nickName")
        profileUIDLabel.text = "UID \(UserDefaults.standard.string(forKey: "userId") ?? "")"
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(profileView)
        
        [
            titleLabel,
            settingButton,
            profileImageView,
            profileNameLabel,
            profileUIDLabel
        ].forEach {
            profileView.addSubview($0)
        }
        
        self.view.addSubview(myTableView)
    }
    
    private func setLayout() {
        profileView.snp.makeConstraints {
            $0.height.equalTo(154)
//            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(24)
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(24)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(58)
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).inset(6)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        profileUIDLabel.snp.makeConstraints {
            $0.top.equalTo(profileNameLabel.snp.bottom).offset(3)
            $0.leading.equalTo(profileNameLabel.snp.leading)
        }
        
        myTableView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .textMain
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(24)
        }
        
        let underLineView = UIView()
        underLineView.backgroundColor = .componentDivider
        headerView.addSubview(underLineView)
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        
        switch section {
        case 0:
            titleLabel.text = "내 활동"
        default:
            titleLabel.text = "메트로스토리"
        }
        
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45 + 16
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.section)_\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        }
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        let arrowImageView = UIImageView().then {
            $0.image = UIImage(named: "right_arrow")
        }
        
        let titleLabel = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            $0.textColor = .textMain
        }
        
        cell.contentView.addSubview(titleLabel)
        cell.contentView.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        switch indexPath.section {
        case 0:
            titleLabel.text = stringArray[indexPath.row]
        default:
            titleLabel.text = "문의하기"
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let myUploadBoardViewController = MyUploadBoardViewController(viewModel: viewModel)
            myUploadBoardViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(myUploadBoardViewController, animated: true)
        } else if indexPath.section == 0 && indexPath.row == 1 {
            let myCommentViewController = MyCommentViewController(viewModel: viewModel)
            myCommentViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(myCommentViewController, animated: true)
        } else {
            self.tabBarController?.tabBar.isHidden = true
            let alertView = AlertView(title: "", message: "‘문의하기'는 <이번역은> 공식 메일로\n바로 연결됩니다!\nthis.stop.is.contact@gmail.com")
            alertView.addAction(title: "취소", style: .cancel)
            {
                alertView.dismiss()
                self.tabBarController?.tabBar.isHidden = false
            }
            alertView.present()
        }
    }
}
