//
//  BoardViewModel.swift
//  BoardFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation
import Network

public class BoardViewModel: NSObject {
    
    var lineInfo: [Lines] = []
    
    var selectedLineArray: [Lines] = []
    var selectedCategoryArray: [String] = []
    var canSelect: Bool = false
    
    // 호선 정보 가져오기
    public func getSubwayLine(completionHandler: @escaping (() -> ())) {
        // /api/v1/subway/lines
        APIServiceManager().request(with: getLine()) { result in
            switch result {
            case .success(let success):
                self.lineInfo = success.data.lines
                DispatchQueue.main.async {
                    completionHandler()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getLine() -> Endpoint<SubwayLineData> {
        return Endpoint(
            path: "api/v1/subway/lines"
        )
    }
    
    // 선택한 호선 저장
    public func addSelectLine(lineInfo: Lines, tag: Int) {
        // 5개만 선택 가능하도록
        if selectedLineArray.count < 5 {
            selectedLineArray.append(lineInfo)
            canSelect = true
            print("👾 추가 완료 : \(selectedLineArray)")
        } else {
            print("최대 5개까지만 선택할 수 있어요.")
            canSelect = false
        }
    }
    
    // 선택한 호선 삭제
    public func removeSelectLine(lineInfo: Lines, tag: Int) {
        canSelect = true
        selectedLineArray = selectedLineArray.filter { $0.id != lineInfo.id }
        
        print("🗑 삭제 완료 : \(selectedLineArray)")
    }
    
    // 선택한 카테고리 저장
    public func addSelectCategory(category: String, tag: Int) {
        if category != "전체" {
            selectedCategoryArray.append(category)
            print("👾 추가 완료 : \(selectedCategoryArray)")
        } else {
            selectedCategoryArray.removeAll()
        }
    }
    
    // 선택한 카테고리 삭제, 전체 선택 시 전부 삭제
    public func removeSelectCategory(category: String, tag: Int) {
        // 전체 선택 시 선택한 카테고리 전부 해제
        if tag == 0 {
            selectedCategoryArray.removeAll()
        } else {
            selectedCategoryArray = selectedCategoryArray.filter { $0 != category }
        }
        
        print("🗑 삭제 완료 : \(selectedCategoryArray)")
    }
}
