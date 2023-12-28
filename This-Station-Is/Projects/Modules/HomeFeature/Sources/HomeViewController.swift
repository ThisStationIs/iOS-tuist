//
//  HomeViewController.swift
//  HomeFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import SnapKit
import Then
import Network

public class HomeViewController: UIViewController {
    private let searchBar = UISearchBar().then {
        $0.placeholder = "키워드를 검색해보세요"
    }
    private let scrollView = UIScrollView()
    private let hotBoardLabel = UILabel().then {
        $0.text = "🔥 이번 주 HOT 게시글!"
        $0.textColor = .textMain
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    lazy var hotBoardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.backgroundColor = .white
        $0.register(HomeBoardCollectionViewCell.self, forCellWithReuseIdentifier: "HomeBoardCollectionViewCell")
    }
    private let newBoardLabel = UILabel().then {
        $0.text = "🌟 이번 주 최신글"
        $0.textColor = .textMain
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    private let recentBoardTableView = UITableView().then {
        $0.register(HomeBoardTableViewCell.self, forCellReuseIdentifier: "HomeBoardTableViewCell")
        
        $0.isScrollEnabled = false
        
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 216
    }

    private var lineInfo: [Lines] = []
    private var recentBoards: [Post] = []
    private var hotBoards: [Post] = []
    
    let viewModel = HomeViewModel()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarBgColor(bgColor: .white)
        navigationItem.titleView = searchBar
        
        viewModel.getSubwayLine { lines in
            self.lineInfo = lines
        }
        
        APIServiceManager().request(with: viewModel.getHomeRecentPosts()) { result in
            switch result {
            case .success(let success):
                print("### success: \(success)")
                self.recentBoards = success.data.posts
                DispatchQueue.main.async {
                    print("### recentBoards:\(self.recentBoards)")
                    self.recentBoardTableView.reloadData()
                    self.recentBoardTableView.snp.updateConstraints {
                        $0.height.equalTo(216 * self.recentBoards.count)
                    }
                }
            case .failure(let failure):
                print("### failure: \(failure)")
            }
        }
        
        APIServiceManager().request(with: viewModel.getHomeHotPosts()) { result in
            switch result {
            case .success(let success):
                print("### success: \(success)")
                self.hotBoards = success.data.posts
                DispatchQueue.main.async {
                    print("### hotBoards:\(self.hotBoards)")
                    self.hotBoardCollectionView.reloadData()
                }
            case .failure(let failure):
                print("### failure: \(failure)")
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setDelegate()
    }
}

extension HomeViewController {
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        [
            hotBoardLabel,
            hotBoardCollectionView,
            newBoardLabel,
            recentBoardTableView
        ].forEach {
            scrollView.addSubview($0)
        }
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(view.bounds.width)
        }
        
        hotBoardLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(24)
            $0.leading.trailing.equalToSuperview()
                .offset(24)
            $0.width.equalTo(scrollView)
        }
        
        hotBoardCollectionView.snp.makeConstraints {
            $0.top.equalTo(hotBoardLabel.snp.bottom)
                .offset(8)
            $0.leading.equalToSuperview()
                .offset(24)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }
        newBoardLabel.snp.makeConstraints {
            $0.top.equalTo(hotBoardCollectionView.snp.bottom)
                .offset(24)
            $0.leading.trailing.equalTo(hotBoardLabel)
        }
        
        recentBoardTableView.snp.makeConstraints {
            $0.top.equalTo(newBoardLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(216 * recentBoards.count)
        }
    }
    
    private func setDelegate() {
        searchBar.delegate = self
        
        hotBoardCollectionView.delegate = self
        hotBoardCollectionView.dataSource = self
        
        recentBoardTableView.delegate = self
        recentBoardTableView.dataSource = self
    }
}

extension HomeViewController: UISearchBarDelegate {
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let nextVC = HomeSearchViewController()
        nextVC.lineInfo = self.lineInfo
        self.navigationController?.pushViewController(nextVC, animated: true)
        searchBar.resignFirstResponder()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotBoards.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBoardCollectionViewCell", for: indexPath) as! HomeBoardCollectionViewCell
        cell.setData(
            self.hotBoards[indexPath.row],
            self.lineInfo
        )
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 318, height: 216)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentBoards.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBoardTableViewCell", for: indexPath) as! HomeBoardTableViewCell
        cell.selectionStyle = .none
        cell.setData(
            self.recentBoards[indexPath.row],
            self.lineInfo
        )
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 216
    }
}
