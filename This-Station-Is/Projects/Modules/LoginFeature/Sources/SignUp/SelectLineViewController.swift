//
//  SelectLineViewController.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import UI
import SnapKit
import Then
import CommonProtocol

public class SelectLineViewController: UIViewController {
    private let descriptionLabel = BigDescriptionLabel().then {
        $0.text = "평소 이용하시는\n지하철 호선을 선택해주세요."
        $0.textColor = .textMain
    }
    private let lineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.allowsMultipleSelection = true
        $0.register(SelectLineCollectionViewCell.self, forCellWithReuseIdentifier: "SelectLineCollectionViewCell")
        $0.backgroundColor = .white
    }
    private let bottomButton = Button().then {
        $0.title = "가입완료"
        $0.isEnabled = false
    }
    
    private let viewModel = SignUpViewModel.shared
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation(tintColor: .textMain)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setDelegate()
        setBinding()
    }
}

extension SelectLineViewController {
    private func setView() {
        view.backgroundColor = .white
        [
            descriptionLabel,
            lineCollectionView,
            bottomButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
                .offset(16)
            $0.leading.equalToSuperview()
                .offset(24)
        }
        
        lineCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
                .offset(40)
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.bottom.equalTo(bottomButton.snp.top)
                .offset(-16)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
                .inset(24)
            $0.bottom.equalToSuperview()
                .inset(24)
        }
    }
    
    private func setDelegate() {
        lineCollectionView.dataSource = self
        lineCollectionView.delegate = self
    }
    
    private func setBinding() {
        bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func bottomButtonTapped() {
        guard let selectedItems = lineCollectionView.indexPathsForSelectedItems else { return }
        for selectedItem in selectedItems {
            DataManager.shared.userSelectedLines.append(DataManager.shared.lineInfos[selectedItem.item])
        }
        viewModel.postSignUp {
            DispatchQueue.main.async {
                let nextVC = FinishSignUpViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}

extension SelectLineViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.lineInfos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectLineCollectionViewCell", for: indexPath) as! SelectLineCollectionViewCell
        cell.configureCell(DataManager.shared.lineInfos[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectLineCollectionViewCell
        cell.selectedCell(DataManager.shared.lineInfos[indexPath.row])
        updateButtonStatus(collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectLineCollectionViewCell
        cell.unselectedCell()
        
    }
    
    private func updateButtonStatus(_ collectionView: UICollectionView) {
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count > 0 {
            // 선택된 셀이 한 개 이상이면 버튼을 활성화합니다.
            bottomButton.isEnabled = true
        } else {
            // 선택된 셀이 없으면 버튼을 비활성화합니다.
            bottomButton.isEnabled = false
        }
    }

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count >= 5 {
            return selectedItems.contains(indexPath)
        } else {
            return true
        }
    }

    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 24
        let width = (collectionView.frame.width - padding*2) / 3
        return CGSize(width: width, height: 48)
    }
}
