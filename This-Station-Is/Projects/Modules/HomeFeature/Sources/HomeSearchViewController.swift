//
//  HomeSearchViewController.swift
//  HomeFeature
//
//  Created by Muzlive_Player on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

public class HomeSearchViewController: UIViewController {
    private let searchBar = UISearchBar().then {
        $0.placeholder = "키워드를 검색해보세요"
    }
    private let historyTitleLabel = UILabel().then {
        $0.text = "검색기록"
        $0.textColor = .textMain
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    private let searchHistoryTableView = UITableView().then {
        $0.register(HomeSearchTableViewCell.self, forCellReuseIdentifier: "HomeSearchTableViewCell")
    }
    
    var historys: [String] = ["test"]
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = searchBar
        
        let customBackImage = UIImage(named: "arrow-up")?.withRenderingMode(.alwaysTemplate)
        
        // 왼쪽 버튼을 커스텀 화살표 이미지로 설정
        let backButton = UIBarButtonItem(image: customBackImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .textMain
        navigationItem.leftBarButtonItem = backButton
        
    }

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setDelegate()
    }
}

extension HomeSearchViewController {
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(historyTitleLabel)
        view.addSubview(searchHistoryTableView)
    }
    
    private func setLayout() {
        historyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
                .offset(16)
            $0.leading.equalToSuperview()
                .offset(24)
        }
        
        searchHistoryTableView.snp.makeConstraints {
            $0.top.equalTo(historyTitleLabel.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
        }
    }
    
    private func setDelegate() {
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
    }
    
    // 왼쪽 버튼 탭 동작
    @objc
    private func backButtonTapped() {
        // 여기에 백 버튼을 탭했을 때의 동작을 작성하세요.
        navigationController?.popViewController(animated: true)
    }
}

extension HomeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historys.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSearchTableViewCell", for: indexPath) as! HomeSearchTableViewCell
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

