//
//  TextView.swift
//  UI
//
//  Created by min on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import Then

@objc public protocol TextViewDelegate {
    @objc optional func textViewDidBeginEditing(_ textView: UITextView)
    @objc optional func textViewDidEndEditing(_ textView: UITextView)
    @objc optional func textViewDidChange(_ textView: UITextView)
}

public class TextView: UITextView {
    
    public var textViewDelegate: TextViewDelegate?
    
    private let placeholderLabel = UILabel().then {
        $0.text = "placeholder"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .textTeritory
        $0.numberOfLines = 0
    }
    
    public var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    public init() {
        super.init(frame: .zero, textContainer: .none)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.delegate = self
        self.addSubview(placeholderLabel)
    }
    
    private func setLayout() {
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension TextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        print("🤯 textViewDidBeginEditing")
        placeholderLabel.isHidden = true
        
        textViewDelegate?.textViewDidBeginEditing?(textView)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        placeholderLabel.isHidden = text.isEmpty ? false : true
        
        textViewDelegate?.textViewDidEndEditing?(textView)
    }
        
    public func textViewDidChange(_ textView: UITextView) {
        textViewDelegate?.textViewDidChange?(textView)
    }
}
