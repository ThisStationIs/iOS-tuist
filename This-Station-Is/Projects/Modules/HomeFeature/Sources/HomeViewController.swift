//
//  HomeViewController.swift
//  HomeFeature
//
//  Created by Muzlive_Player on 2023/12/27.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit
import SnapKit
import Then

public class HomeViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "키워드를 검색해보세요"
    }
    let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    lazy var hotBoardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.backgroundColor = .black
    }

    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.searchController = searchController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
    }
}

extension HomeViewController {
    private func setView() {
        view.backgroundColor = .white
        [
            hotBoardCollectionView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        hotBoardCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
                .offset(24)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }
    }
    
    private func setDelegate() {
        hotBoardCollectionView.delegate = self
        hotBoardCollectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 318, height: 216)
    }
}
