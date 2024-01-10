//
//  SettingViewController.swift
//  MyPageFeature
//
//  Created by min on 2024/01/10.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import UIKit
import UI

class SettingViewController: UIViewController {
    
    private lazy var mainTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
    }
    
    private var viewModel: MyPageViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "설정"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textMain]
        self.changeStatusBarBgColor(bgColor: .white)
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(selectLeftBarButton))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    init(viewModel: MyPageViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    @objc func selectLeftBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func logout() {
        let alert = AlertView(title: "로그아웃할까요?", message: "정말로 로그아웃 하시겠어요?")
        alert.addAction(title: "취소", style: .cancel)
        alert.addAction(title: "로그아웃", style: .destructive) {
            self.viewModel.postLogoutData {
                // 로그인 화면으로 이동 MoveToLogin
                NotificationCenter.default.post(name: NSNotification.Name("MoveToLogin"), object: nil)
            }
        }
        alert.present()
    }
    
    private func unregister() {
        
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(mainTableView)
    }
    
    private func setLayout() {
        mainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let titleLabel = UILabel().then {
            $0.text = "기타"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        let underLineView = UIView().then {
            $0.backgroundColor = .componentDivider
        }
        headerView.addSubview(underLineView)
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        let titleLabel = UILabel()
        cell.contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        switch indexPath.row {
        case 0:
            titleLabel.text = "로그아웃"
            titleLabel.textColor = .statusNegative
        case 1:
            titleLabel.text = "회원탈퇴"
            titleLabel.textColor = .textSub
        default:
            titleLabel.text = ""
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.logout()
        case 1:
            self.unregister()
        default:
            print("default")
        }
    }
}
