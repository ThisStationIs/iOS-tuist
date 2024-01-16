//
//  BoardUploadViewController.swift
//  BoardFeature
//
//  Created by min on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

public class BoardUploadViewController: UIViewController {
    
    public enum UploadType {
        case new
        case edit
    }
    
    lazy var mainTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.delegate = self
        $0.dataSource = self
        $0.estimatedRowHeight = 72
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    var rightBarItemForSetting: UIBarButtonItem!
    var viewModel: BoardViewModel!
    var uploadType: UploadType = .new
    
    var titleText: String = ""
    var contentText: String = ""
    
    public init(viewModel: BoardViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    public init(viewModel: BoardViewModel, uploadType: UploadType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.uploadType = uploadType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    @objc func selectLeftBarButton() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    @objc func selectUploadPost() {
        
        if let titleCell = mainTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? BoardTitleTableViewCell {
            self.viewModel.uploadBoardData["title"] = titleCell.getText()
        }
        
        if let contentCell = mainTableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? BoardContentTableViewCell {
            self.viewModel.uploadBoardData["content"] = contentCell.getText()
        }
        
        // 데이터 세팅
        guard let categoryId = self.viewModel.uploadBoardData["categoryId"] as? Int,
              let subwayLineId = self.viewModel.uploadBoardData["subwayLineId"] as? Int,
              let title = self.viewModel.uploadBoardData["title"] as? String,
              let content = self.viewModel.uploadBoardData["content"] as? String
        else {
            return
        }
        
        print("data : \(viewModel.uploadBoardData)")
        
        // 새로 업로드 시
        if uploadType == .new {
            print("uploadType : New")
            let uploadBoardData = UploadBoardData(categoryId: categoryId, subwayLineId: subwayLineId, title: title, content: content)
            
            self.viewModel.postBoardData(uploadData: uploadBoardData) {
                //
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true)
            }
        } else {
            print("uploadType : Edit")
            let editData = EditData(categoryId: categoryId, subwayLineId: subwayLineId, title: title, content: content)
            self.viewModel.putEditBoardData(postId: viewModel.detailBoardData.postId, editData: editData) {
                //
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true)
            }
        }
    }
    
    private func setUI() {
        self.title = "게시글 작성"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textMain]
        setupRightBarButtonItem()
        
        self.view.backgroundColor = .white
        self.navigationController?.hidesBarsOnSwipe = false
        self.view.addSubview(mainTableView)
    }
    
    private func setLayout() {
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupRightBarButtonItem() {
        guard let originalImage = UIImage(named: "send") else { return }
        
        let resizedImage = originalImage.resized(to: CGSize(width: 24, height: 24))
        
        let tintedImage = resizedImage?.withTintColor(.primaryNormal, renderingMode: .alwaysOriginal)

        rightBarItemForSetting = UIBarButtonItem(image: tintedImage, style: .plain, target: self, action: #selector(selectUploadPost))
        navigationItem.rightBarButtonItem = rightBarItemForSetting
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(selectLeftBarButton))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
}

extension BoardUploadViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 24 + 8
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .textMain
        headerView.addSubview(titleLabel)
        
        switch section {
        case 0:
            titleLabel.text = "호선 선택"
            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(24)
                $0.centerY.equalToSuperview().inset(8)
            }
            return headerView
        case 1:
            titleLabel.text = "태그 선택"
            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(24)
                $0.centerY.equalToSuperview().inset(8)
            }
            return headerView
        default:
            titleLabel.isHidden = true
            return headerView
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        return footerView
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.section) \(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        }
        
        switch indexPath.section {
        case 0:
            let cell = SelectLineTableViewCell.init(
                reuseIdentifier: identifier,
                viewModel: viewModel,
                defaultLine: uploadType == .new ? "" : viewModel.detailBoardData.subwayLineName
            )
            return cell
        case 1:
            let cell = SelectTagTableViewCell.init(
                reuseIdentifier: identifier,
                viewModel: viewModel,
                defaultTag: uploadType == .new ? "" : viewModel.detailBoardData.categoryName
            )
            return cell
        case 2:
            let cell = BoardTitleTableViewCell.init(reuseIdentifier: identifier)
            if uploadType != .new { cell.setDefaultTitle(viewModel.detailBoardData.title) }
            return cell
        case 3:
            let cell = BoardContentTableViewCell.init(reuseIdentifier: identifier)
            cell.delegate = self
            if uploadType != .new { cell.setDefaultContent(viewModel.detailBoardData.content) }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension BoardUploadViewController: BoardContentCellDelegate {
    func updateTextViewHeight(_ cell: BoardContentTableViewCell, textView: UITextView) {
        let size = textView.bounds.size
        let newSize = mainTableView.sizeThatFits(.init(width: size.width, height: size.height))
        
        print("🤯 size : \(size.height)")
        print("🤯 newSize : \(newSize.height)")
        
        // TODO: 동적으로 TextView 높이 조절
        
//        if size.height != newSize.height {
//            UIView.setAnimationsEnabled(false)
//            mainTableView.beginUpdates()
//            mainTableView.endUpdates()
//            UIView.setAnimationsEnabled(true)
//        }
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
         UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
         self.draw(in: CGRect(origin: .zero, size: size))
         let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return resizedImage
     }
}
