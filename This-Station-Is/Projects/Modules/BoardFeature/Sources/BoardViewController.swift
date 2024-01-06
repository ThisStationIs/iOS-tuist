//
//  BoardViewController.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UI
import HomeFeature
import CommonProtocol

public class BoardViewController: UIViewController {
    
    private lazy var mainBoardTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 232
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    
    private lazy var categoryView = CateogryView().then {
        $0.categoryTapGesture = categoryTapGesture
    }
    
    private lazy var tableHeaderView = BoardTableHeaderView(viewModel: viewModel).then {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectTableHeaderView))
        $0.addGestureRecognizer(gesture)
    }
    
    private lazy var searchBar = UISearchBar().then {
        $0.delegate = self
        $0.setImage(UIImage(named: "search"), for: .search, state: .normal)
        $0.searchTextField.attributedPlaceholder = NSAttributedString(string: "찾으시는게 있나요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textSub])
        $0.searchTextField.textColor = .textMain
    }
    
    let viewModel = BoardViewModel()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO: 스크롤 올리면 내려오지 않음 문제 해결 필요
//        self.navigationController?.hidesBarsOnSwipe = true
        self.changeStatusBarBgColor(bgColor: .white)
        self.navigationController?.navigationBar.barTintColor = .white
        
        viewModel.getBoardData {
            self.mainBoardTableView.reloadData()
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 호선 업데이트
        tableHeaderView.setUpLineView()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.hidesBarsOnSwipe = false
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
//        viewModel.getBoardData { [self] in
//
//        }
    }
    
    @objc func selectTableHeaderView() {
        let selectSubwayLineViewController = SelectSubwayLineViewController(viewModel: viewModel)
        selectSubwayLineViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(selectSubwayLineViewController, animated: true)
    }
    
    @objc func selectFilterButton() {
//        let bottomSheetView = BottomSheetView(defaultHeight: 270, title: "게시판 정렬")
//        bottomSheetView.addContentView(BoardFilterView())
//        bottomSheetView.show()
    }
    
    private func categoryTapGesture(badgeView: FilterBadge) {
        badgeView.isSelect.toggle()
        if badgeView.isSelect {
            viewModel.addSelectCategory(category: categoryView.categoryArray[badgeView.tag].name, tag: badgeView.tag)
        }
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationItem.titleView = searchBar
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(selectFilterButton))
//        self.navigationItem.rightBarButtonItem = filterButton
        self.view.addSubview(mainBoardTableView)
    }
    
    private func setLayout() {
        
        mainBoardTableView.snp.makeConstraints {
//            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setTableHeaderView() {
        
    }
}

extension BoardViewController: UISearchBarDelegate {
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let nextVC = HomeSearchViewController()
//        nextVC.lineInfo = self.viewModel.lineInfo
        self.navigationController?.pushViewController(nextVC, animated: true)
        searchBar.resignFirstResponder()
    }
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.boardArray.count + 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeaderView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row == 0 {
            let identidier = "CATEGORY_\(indexPath.row)"
            
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: identidier)
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            cell.contentView.addSubview(categoryView)
            
            return cell
        } else {
            let post = viewModel.boardArray[indexPath.row - 1]
            let identifier = "LIST_\(indexPath.row)_\(post.postId)_\(post.commentCount)"
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            }
            
            let cell = BoardTableViewCell(reuseIdentifier: identifier, boardData: post, colorInfos: DataManager.shared.lineInfos)
           
            
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = viewModel.boardArray[indexPath.row - 1].postId
        
        let boardDetailViewController = BoardDetailViewController(viewModel: viewModel, id: id)
        boardDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(boardDetailViewController, animated: true)
    }
}
