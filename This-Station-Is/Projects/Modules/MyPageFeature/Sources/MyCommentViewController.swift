//
//  MyCommentViewController.swift
//  MyPageFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class MyCommentViewController: UIViewController {
    
    private lazy var mainTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = 99
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    
    var viewModel: MyPageViewModel!
    
    init(viewModel: MyPageViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        
        self.viewModel.getMyCommentData { [self] returnType in
            setUI()
            setLayout()
            
            if returnType == .failure {
                let emptyView = EmptyView(message: "댓글이 존재하지 않습니다.")
                self.view.addSubview(emptyView)
                emptyView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "내가 쓴 댓글"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textMain]
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(selectLeftBarButton))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func selectLeftBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(mainTableView)
    }
    
    private func setLayout() {
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MyCommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myCommentData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.myCommentData[indexPath.row]
        let identifier = "\(indexPath.row)_\(data.commentId)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        }
        
        let cell = MyCommentTableViewCell.init(reuseIdentifier: identifier, data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = viewModel.myCommentData[indexPath.row]
        
        if comment.isBlocked {
            let alertView = AlertView(title: "신고된 댓글이에요.", message: "해당 댓글은 신고 누적으로 인해\n삭제되었어요.\n게시글로 이동할까요?")
            alertView.addAction(title: "아니오", style: .cancel)
            alertView.addAction(title: "네", style: .default) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MoveToBoardDetail"), object: comment.postId)
            }
            alertView.present()
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MoveToBoardDetail"), object: comment.postId)
        }
    }
}
