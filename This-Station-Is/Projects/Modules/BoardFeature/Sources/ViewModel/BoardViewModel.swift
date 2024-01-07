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
    
    var boardArray: [Post] = []
    var detailBoardData: DetailPost!
    var lineInfo: [Lines] = []
    var commentData: [Comments] = []
    var uploadBoardData: [String: Any] = [:]
    
    var selectedLineArray: [Lines] = []
    var selectedCategoryArray: [String] = []
    var canSelect: Bool = false
    
    // eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXNlcklkIjoxLCJpc3N1ZWRBdCI6IjIwMjMtMTItMjggMDI6MzY6MDQiLCJleHBpcmF0aW9uQXQiOiIyMDIzLTEyLTI5IDAyOjM2OjA0In0.emd0bOvM077ExVd4XdqrfkPhhlcKCSoupzAYSdwEbPqPOJOavYBFTc1I6dqGcdMo5UQTah-NFjhcZ241pXvX8g
    var ACCESS_TOKEN: String = "" {
        didSet {
            UserDefaults.standard.string(forKey: "accessToken")
        }
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

extension BoardViewModel {
    // 호선 정보 가져오기
    public func getSubwayLine(completion: @escaping (() -> ())) {
        // /api/v1/subway/lines
        APIServiceManager().request(with: getLine()) { result in
            switch result {
            case .success(let success):
                self.lineInfo = success.data.lines
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getLine() -> Endpoint<SubwayLineModel> {
        return Endpoint(
            path: "api/v1/subway/lines"
        )
    }
    
    // 게시판 리스트 가져오기
    public func getBoardData(completion: @escaping (() -> ())) {
        APIServiceManager().request(with: getBoard()) { result in
            switch result {
            case .success(let success):
                self.boardArray = success.data.posts
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getBoard() -> Endpoint<BoardModel<BoardData>> {
        return Endpoint(
            path: "api/v1/posts"
        )
    }
     
    // 게시판 상세
    public func getDetailBoardData(id: Int, completion: @escaping (() -> ())) {
        APIServiceManager().request(with: getDetailBoard(id: id)) { result in
            switch result {
            case .success(let success):
                self.detailBoardData = success.data
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getDetailBoard(id: Int) -> Endpoint<BoardModel<DetailPost>> {
        return Endpoint(
            path: "api/v1/post/\(id)"
        )
    }
    
    // 게시판 등록
    public func postBoardData(uploadData: UploadBoardData, completion: @escaping (() -> ())) {
        APIServiceManager().request(with: postBoar(uploadData: uploadData)) { result in
            switch result {
            case .success(let success):
                print(success)
//                self.detailBoardData = success.data
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func postBoar(uploadData: UploadBoardData) -> Endpoint<BoardModel<UploadBoardResponse>> {
        
        let headers: [String: String] = [
            "X-STATION-ACCESS-TOKEN": ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        
        return Endpoint(
            path: "api/v1/post",
            method: .post,
            bodyParameters: uploadData,
            headers: headers
        )
    }
    
    // 댓글
    public func getCommentData(id: Int, completion: @escaping (() -> ())) {
        APIServiceManager().request(with: getComment(id: id)) { result in
            switch result {
            case .success(let success):
                print(success)
                self.commentData = success.data.comments
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getComment(id: Int) -> Endpoint<BoardModel<CommentData>> {
        return Endpoint(
            path: "api/v1/post/\(id)/comments"
        )
    }
    
    // 댓글 등록
    public func postCommentData(id: Int, commentData: UploadCommentData, completion: @escaping (() -> ())) {
        APIServiceManager().request(with: postComment(id: id, commentData: commentData)) { result in
            switch result {
            case .success(let success):
                print(success)
//                self.detailBoardData = success.data
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func postComment(id: Int, commentData: UploadCommentData) -> Endpoint<BoardModel<UploadCommentResponse>> {
        
        let headers: [String: String] = [
            "X-STATION-ACCESS-TOKEN": ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        
        return Endpoint(
            path: "api/v1/post/\(id)/comment",
            method: .post,
            bodyParameters: commentData,
            headers: headers
        )
    }
}
