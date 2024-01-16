//
//  BoardViewModel.swift
//  BoardFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation
import Network
import CommonProtocol

public class BoardViewModel: NSObject {
    
    var boardArray: [Post] = []
    var detailBoardData: DetailPost!
    var commentData: [Comments] = []
    var uploadBoardData: [String: Any] = [:]
    
    var selectedLineArray: [DataManager.Line] = [] {
        didSet {
            print("selectedLine 변경 \(selectedLineArray)")
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(selectedLineArray){
                UserDefaults.standard.setValue(encoded, forKey: "selectedLineArray")
                print(encoded)
            }
        }
    }
    
    var selectedCategory: CategoryData? {
        didSet {
            print("selectedCategory 변경 \(selectedCategory)")
            // 카테고리 UserDefault 에 저장
            let encoder = JSONEncoder()
            // encoded는 Data형
            if let encoded = try? encoder.encode(selectedCategory) {
                UserDefaults.standard.setValue(encoded, forKey: "selectedCategory")
            }
        }
    }
    //    var selectedCategory: [String] = []
    var canSelect: Bool = false
    
    // eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXNlcklkIjoxLCJpc3N1ZWRBdCI6IjIwMjMtMTItMjggMDI6MzY6MDQiLCJleHBpcmF0aW9uQXQiOiIyMDIzLTEyLTI5IDAyOjM2OjA0In0.emd0bOvM077ExVd4XdqrfkPhhlcKCSoupzAYSdwEbPqPOJOavYBFTc1I6dqGcdMo5UQTah-NFjhcZ241pXvX8g
    var ACCESS_TOKEN: String = UserDefaults.standard.string(forKey: "accessToken") ?? ""
    
    // 선택한 호선 저장
    public func addSelectLine(lineInfo: DataManager.Line, tag: Int) {
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
    public func removeSelectLine(lineInfo: DataManager.Line, tag: Int) {
        canSelect = true
        selectedLineArray = selectedLineArray.filter { $0.id != lineInfo.id }
        
        print("🗑 삭제 완료 : \(selectedLineArray)")
    }
    
    // 선택한 카테고리 저장
    public func addSelectCategory(category: String, tag: Int) {
        selectedCategory = CategoryData(id: tag, name: category)
        print("👾 추가 완료 : \(selectedCategory)")
    }
}

extension BoardViewModel {
    
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
                print("detailBoardData : \(self.detailBoardData)")
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
    
    // 필터 적용
    public func getFilterBoardData(keyword: String, categoryId: Int, subwayLineIds: [String], completion: @escaping (() -> ())) {
        APIServiceManager().request(with: getFilterData(keyword: keyword, categoryId: categoryId, subwayLineIds: subwayLineIds)) { result in
            switch result {
            case .success(let success):
                print("board Data : \(success.data.posts)")
                self.boardArray = success.data.posts
                //                self.detailBoardData = success.data
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getFilterData(keyword: String, categoryId: Int, subwayLineIds: [String]) -> Endpoint<ResponseWrapper<FilterPostsData>> {
        
        let joinLineIds = subwayLineIds.joined(separator: ",")
        
        // -1 일 경우 전체
        let fileterOptions = FilterOptions(keyword: keyword, categoryId: categoryId == -1 ? "" : "\(categoryId)", subwayLineIds: joinLineIds)
        
        print(fileterOptions)
        
        return Endpoint(
            path: "api/v1/filter/posts",
            queryPrameters: fileterOptions
        )
    }
    
    struct FilterOptions: Encodable {
        let keyword: String
        let categoryId: String
        let subwayLineIds: String
    }
    
    // 게시글 수정
    public func putEditBoardData(postId: Int, editData: EditData, completion: @escaping (() -> ())) {
        APIServiceManager().request(with: putEditData(postId: postId, editData: editData)) { result in
            switch result {
            case .success(let success):
                self.getDetailBoardData(id: postId) {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func putEditData(postId: Int, editData: EditData) -> Endpoint<NullResponse> {
        
        let headers: [String: String] = [
            "X-STATION-ACCESS-TOKEN": ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        
        return Endpoint(
            path: "api/v1/post/\(postId)",
            method: .put,
            bodyParameters: editData,
            headers: headers
        )
    }
    
    // 게시글 삭제
    public func deleteBoardData(postId: Int, completion: @escaping (() -> ())) {
        APIServiceManager().request(with: deleteData(postId: postId)) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func deleteData(postId: Int) -> Endpoint<NullResponse> {
        
        let headers: [String: String] = [
            "X-STATION-ACCESS-TOKEN": ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        
        return Endpoint(
            path: "api/v1/post/\(postId)",
            method: .delete,
            headers: headers
        )
    }
   
}
