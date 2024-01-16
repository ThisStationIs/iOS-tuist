//
//  HomeSearchViewController.swift
//  HomeFeature
//
//  Created by Muzlive_Player on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import Network

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
        $0.backgroundColor = .white
    }
    private let searchTableView = UITableView().then {
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.register(HomeBoardTableViewCell.self, forCellReuseIdentifier: "HomeBoardTableViewCell")
        
        $0.isScrollEnabled = false
        
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 216
    }
    
    var lineInfo: [Lines] = []
    
    private var historys: [String] = []
    private var posts: [Post] = []
    private var filteredPosts: [Post] = []
    
    let viewModel = HomeSearchViewModel()
    
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true

        self.setNavigation(tintColor: .textMain)
        viewModel.loadSearchHistory { historys in
            self.historys = historys
        }
        
        viewModel.getPosts { posts in
            self.posts = posts
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setDelegate()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    public override func setNavigation(tintColor: UIColor) {
        super.setNavigation(tintColor: tintColor)
        navigationItem.titleView = searchBar
    }

    func updateIsHiddenTableViews(_ historyTableViewIsHidden: Bool) {
        searchHistoryTableView.isHidden = historyTableViewIsHidden
        searchTableView.isHidden = !historyTableViewIsHidden
        
        if !historyTableViewIsHidden {
            viewModel.loadSearchHistory { historys in
                self.historys = historys
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            }
        }
    }
}

extension HomeSearchViewController {
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(historyTitleLabel)
        view.addSubview(searchHistoryTableView)
        view.addSubview(searchTableView)
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
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
                .offset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
        }
    }
    
    private func setDelegate() {
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchBar.delegate = self
    }
}

extension HomeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchHistoryTableView {
            return historys.count
        } else {
            return filteredPosts.count == 0 ? 1 : filteredPosts.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchHistoryTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSearchTableViewCell", for: indexPath) as! HomeSearchTableViewCell
            cell.setData(historys[indexPath.row])
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBoardTableViewCell", for: indexPath) as! HomeBoardTableViewCell
            cell.selectionStyle = .none
            
            if filteredPosts.count == 0 {
                cell.updateIsHiddenView(0)
            } else {
                cell.setData(
                    self.filteredPosts[indexPath.row],
                    self.lineInfo
                )
            }
            
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == searchHistoryTableView {
            return 48
        } else {
            return filteredPosts.count == 0 ? tableView.bounds.height : 216
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchHistoryTableView {
            filteredPosts = []
            let searchText = historys[indexPath.row]
            
            updateIsHiddenTableViews(true)
            
            filteredPosts = posts.filter { post in
                return post.title.lowercased().contains(searchText.lowercased()) || post.title.initialConsonants().contains(searchText.lowercased())
            }
            searchTableView.reloadData()
            searchBar.resignFirstResponder()
        } else {
            guard filteredPosts.count > 0 else { return }
            HomeViewModel().getPostDetail(filteredPosts[indexPath.row].postId) { data in
                print("### data: \(data)")
                let id = self.filteredPosts[indexPath.row].postId
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MoveToBoardDetail"), object: id)
            }
        }
        
    }
}

extension HomeSearchViewController: UISearchBarDelegate {
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        updateIsHiddenTableViews(false)
        filteredPosts = []
        return true
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateIsHiddenTableViews(true)
        
        if let searchText = searchBar.text {
            filteredPosts = posts.filter { post in
                return post.title.lowercased().contains(searchText.lowercased()) || post.title.initialConsonants().contains(searchText.lowercased())
            }
            print("### filteredPosts is \(filteredPosts)")
            historys.append(searchText)
            viewModel.saveSearchHistory(self.historys)
        }
        searchTableView.reloadData()
        searchBar.resignFirstResponder()
    }

}

extension String {
    func initialConsonants() -> String {
        let hangle = [
            "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
        ]
        return self.reduce(into: "") { result, char in
            if case let unicodeScalar = char.unicodeScalars.first, unicodeScalar!.value >= 0xAC00 && unicodeScalar!.value <= 0xD7A3 {
                let index = Int(unicodeScalar!.value - 0xAC00) / 28 / 21
                result.append(hangle[index])
            } else {
                result.append(char)
            }
        }
    }
}
