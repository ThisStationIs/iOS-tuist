//
//  BoardDetailViewController.swift
//  BoardFeature
//
//  Created by min on 2023/12/23.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class BoardDetailViewController: UIViewController {
    
    private lazy var detilaTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 192
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    
    private let bottomView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let textField = TextField().then {
        $0.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 48)
        $0.backgroundColor = .componentTextbox
        $0.underLineView.isHidden = true
        $0.placeholder = "댓글을 입력하세요."
        $0.tintColor = .textSub
        $0.layer.cornerRadius = 18
    }
    
    private let sendButton = UIButton().then {
        $0.setImage(UIImage(named: "send"), for: .normal)
    }
    
    private var id: Int!
    private var viewModel: BoardViewModel!
    
    public init(viewModel: BoardViewModel, id: Int) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.id = id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getDetailBoardData(id: id) { [self] in
            setUI()
            setLayout()
        }
    }
    
    @objc func selectLeftBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectMoreButton() {
        let alertView = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "수정하기", style: .default)
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive)
        alertView.addAction(editAction)
        alertView.addAction(deleteAction)
        
        self.present(alertView, animated: true)
    }
    
    private func setUI() {
        self.navigationItem.title = ""
        self.view.backgroundColor = .white
        self.navigationController?.hidesBarsOnSwipe = false
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(selectLeftBarButton))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
    
        let moreButton = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(selectMoreButton))

        self.navigationItem.rightBarButtonItem = moreButton
        
        self.view.addSubview(detilaTableView)
        self.view.addSubview(bottomView)
      
        [
            textField,
            sendButton
        ].forEach {
            bottomView.addSubview($0)
        }

    }
    
    private func setLayout() {
        detilaTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(64)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(64)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        sendButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalTo(sendButton.snp.leading).inset(-8)
        }
    }
}

extension BoardDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.detailBoardData.comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier = "DETAIL_\(indexPath.section)_\(indexPath.row)"
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            }
            
            let cell = BoardDetailContentTableViewCell(reuseIdentifier: identifier, detailData: viewModel.detailBoardData)
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            return cell
        } else {
            let commentData = viewModel.detailBoardData.comments[indexPath.row]
            let identifier = "COMMENT_\(indexPath.section)_\(indexPath.row)_\(commentData.commentId)"
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            }
            
            let cell = CommentTableViewCell(reuseIdentifier: identifier, commentData: commentData)
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            return cell
        }
    }
}
