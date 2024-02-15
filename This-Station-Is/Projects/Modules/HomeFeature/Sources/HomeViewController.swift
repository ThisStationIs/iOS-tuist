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
import CommonProtocol

public class HomeViewController: UIViewController {
    private let searchBar = UISearchBar().then {
        $0.setImage(UIImage(named: "search"), for: .search, state: .normal)
        $0.searchTextField.attributedPlaceholder = NSAttributedString(string: "키워드를 검색해보세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textSub])
        $0.searchTextField.textColor = .textMain
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
        $0.showsHorizontalScrollIndicator = false
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
    private let refreshControl = UIRefreshControl()

    private var lineInfo: [DataManager.Line] = []
    private var recentBoards: [Post] = []
    private var hotBoards: [Post] = []
    
    let viewModel = HomeViewModel()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = searchBar
        
//        viewModel.getSubwayLine { lines in
//            self.lineInfo = lines
//        }
        self.lineInfo = DataManager.shared.lineInfos
        
        fetchRecentPosts()
        fetchHotPosts()
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
        
        setRefreshControlToScrollView()
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
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension HomeViewController {
    private func setRefreshControlToScrollView() {
        scrollView.refreshControl = self.refreshControl
        setRefreshControl()
    }
    
    private func setRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fetchRecentPosts()
            self.fetchHotPosts()
            self.refreshControl.endRefreshing()
        }
    }
}

extension HomeViewController {
    private func fetchRecentPosts() {
        viewModel.getHomeRecentPosts() { [weak self] posts in
            guard let self = self else { return }
            self.recentBoards = self.viewModel.filterWithReport(to: posts)
            self.updateRecentBoard()
        }
    }
    
    private func updateRecentBoard() {
        DispatchQueue.main.async {
            self.recentBoardTableView.reloadData()
            self.updateRecentBoardHeight()
        }
    }
    
    private func updateRecentBoardHeight() {
        self.recentBoardTableView.snp.updateConstraints {
            $0.height.equalTo(216 * self.recentBoards.count)
        }
    }
    
    private func fetchHotPosts() {
        viewModel.getHomeHotPosts { [weak self] posts in
            guard let self = self else { return }
            self.hotBoards = viewModel.filterWithReport(to: posts)
            self.updateHotBoard()
        }
    }
    
    private func updateHotBoard() {
        DispatchQueue.main.async {
            self.hotBoardCollectionView.reloadData()
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let nextVC = HomeSearchViewController()
        nextVC.lineInfo = DataManager.shared.lineInfos
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
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MoveToBoardDetail"), object: hotBoards[indexPath.row].postId)
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
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MoveToBoardDetail"), object: recentBoards[indexPath.row].postId)
    }
}

extension HomeViewController: UIGestureRecognizerDelegate{
    // MARK: swipe Back 사용하기 위한 Delegate
}
