//
//  BoardUploadViewController.swift
//  BoardFeature
//
//  Created by min on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

class BoardUploadViewController: UIViewController {
    
    lazy var mainTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.delegate = self
        $0.dataSource = self
        $0.estimatedRowHeight = 72
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    var rightBarItemForSetting: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    @objc func selectLeftBarButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectUploadPost() {
        
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 24 + 8
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.section) \(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        }
        
        switch indexPath.section {
        case 0:
            let cell = SelectLineTableViewCell.init(reuseIdentifier: identifier)
            return cell
        case 1:
            let cell = SelectTagTableViewCell.init(reuseIdentifier: identifier)
            return cell
        case 2:
            let cell = BoardTitleTableViewCell.init(reuseIdentifier: identifier)
            return cell
        case 3:
            let cell = BoardContentTableViewCell.init(reuseIdentifier: identifier)
            cell.delegate = self
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
