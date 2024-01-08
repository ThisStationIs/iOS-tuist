//
//  MyPageViewModel.swift
//  MyPageFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation
import Network

public class MyPageViewModel: NSObject {
    var myUploadBoardData: [Post] = []
    var myCommentData: [Comments] = []
    var lineInfo: [Lines] = []
    
    /*
     "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXNlcklkIjoxLCJpc3N1ZWRBdCI6IjIwMjMtMTItMjggMDI6MzY6MDQiLCJleHBpcmF0aW9uQXQiOiIyMDIzLTEyLTI5IDAyOjM2OjA0In0.emd0bOvM077ExVd4XdqrfkPhhlcKCSoupzAYSdwEbPqPOJOavYBFTc1I6dqGcdMo5UQTah-NFjhcZ241pXvX8g"
     */
    var ACCESS_TOKEN: String = "" {
        didSet {
            UserDefaults.standard.string(forKey: "accessToken")
        }
    }
}

extension MyPageViewModel {
    // 내가 쓴 글
    public func getMyUploadBoardData(completion: @escaping (() -> ())) {
        APIServiceManager().request(with: getMyUploadBoard()) { result in
            switch result {
            case .success(let success):
                self.myUploadBoardData = success.data.posts
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getMyUploadBoard() -> Endpoint<ResponseWrapper<MyUploadBoardData>> {
        let headers: [String: String] = [
            "X-STATION-ACCESS-TOKEN": ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        
        return Endpoint(
            path: "api/v1/my/posts",
            headers: headers
        )
    }
    
    // 내가 쓴 댓글
    public func getMyCommentData(completion: @escaping (() -> ())) {
        APIServiceManager().request(with: getMyComment()) { result in
            switch result {
            case .success(let success):
                self.myCommentData = success.data.comments
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getMyComment() -> Endpoint<ResponseWrapper<MyCommentData>> {
        let headers: [String: String] = [
            "X-STATION-ACCESS-TOKEN": ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        
        return Endpoint(
            path: "api/v1/my/comments",
            headers: headers
        )
    }
    
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
}
