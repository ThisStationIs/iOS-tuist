//
//  BoardContentTableViewCell.swift
//  BoardFeature
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI

protocol BoardContentCellDelegate {
    func updateTextViewHeight(_ cell: BoardContentTableViewCell, textView: UITextView)
}

class BoardContentTableViewCell: UITableViewCell {
    
    var delegate: BoardContentCellDelegate?
    
    private let containerView = UIView()

    private lazy var contentTextView = TextView().then {
        $0.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 506)
        $0.backgroundColor = .white
        $0.textViewDelegate = self
        $0.isScrollEnabled = false
        $0.sizeToFit()
        $0.textColor = .textMain
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.placeholder = "선택하신 태그와 관련된 글로 입력해주세요.\n댓글이 있는 경우 수정이 불가능합니다."
//        $0.placeholder = "제목을 입력해주세요"
    }
    
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getText() -> String {
        guard let text = contentTextView.text else { return "" }
        return text
    }
    
    public func setDefaultContent(_ content: String) {
        contentTextView.text = content
        contentTextView.textViewDidBeginEditing(contentTextView)
    }
    
    private func setUI() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.contentView.addSubview(containerView)
        containerView.addSubview(contentTextView)
    }
    
    private func setLayout() {
        contentTextView.snp.makeConstraints {
            $0.height.equalTo(506)
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.top)
            $0.bottom.equalTo(contentTextView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview()
        }
    }
}

extension BoardContentTableViewCell: TextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = delegate {
            delegate.updateTextViewHeight(self, textView: textView)
        }
    }
}
