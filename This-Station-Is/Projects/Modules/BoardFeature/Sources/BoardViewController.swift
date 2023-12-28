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

public class BoardViewController: UIViewController {
    
    private lazy var mainBoardTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 232
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    
    private let categoryView = CateogryView()
    private lazy var tableHeaderView = BoardTableHeaderView(viewModel: viewModel).then {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectTableHeaderView))
        $0.addGestureRecognizer(gesture)
    }
    
    private let searchBar = UISearchBar().then {
        $0.searchTextField.attributedPlaceholder = NSAttributedString(string: "찾으시는게 있나요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textSub])
        $0.searchTextField.textColor = .textMain
    }
    
    let viewModel = BoardViewModel()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainBoardTableView.reloadData()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 호선 업데이트
        tableHeaderView.setUpLineView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getBoardData { [self] in
            setUI()
            setLayout()
        }
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
        
        // TODO: 테스트
        let boardUploadViewController = BoardUploadViewController(viewModel: viewModel)
        boardUploadViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(boardUploadViewController, animated: true)
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationItem.titleView = searchBar
        self.changeStatusBarBgColor(bgColor: UIColor.white)
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(selectFilterButton))
        self.navigationItem.rightBarButtonItem = filterButton
        
        // TODO: 스크롤 올리면 내려오지 않음 문제 해결 필요
        self.navigationController?.hidesBarsOnSwipe = true
        
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
    
    func changeStatusBarBgColor(bgColor: UIColor?) {
         if #available(iOS 13.0, *) {
             let window = UIApplication.shared.windows.first
             let statusBarManager = window?.windowScene?.statusBarManager
             
             let statusBarView = UIView(frame: statusBarManager?.statusBarFrame ?? .zero)
             statusBarView.backgroundColor = bgColor
             window?.addSubview(statusBarView)
         } else {
             let statusBarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
             statusBarView?.backgroundColor = bgColor
         }
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
            let identifier = "LIST_\(indexPath.row)_\(post.postId)"
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            }
            
            let cell = BoardTableViewCell(reuseIdentifier: identifier, boardData: post)
           
            
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
