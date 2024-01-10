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
    
    /*
     "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXNlcklkIjoxLCJpc3N1ZWRBdCI6IjIwMjMtMTItMjggMDI6MzY6MDQiLCJleHBpcmF0aW9uQXQiOiIyMDIzLTEyLTI5IDAyOjM2OjA0In0.emd0bOvM077ExVd4XdqrfkPhhlcKCSoupzAYSdwEbPqPOJOavYBFTc1I6dqGcdMo5UQTah-NFjhcZ241pXvX8g"
     */
    var ACCESS_TOKEN: String = UserDefaults.standard.string(forKey: "accessToken") ?? ""
}

extension MyPageViewModel {
    public enum ReturnType {
        case success
        case failure
    }
    
    // 내가 쓴 글
    public func getMyUploadBoardData(completion: @escaping ((_ returnType: ReturnType) -> ())) {
        APIServiceManager().request(with: getMyUploadBoard()) { result in
            switch result {
            case .success(let success):
                self.myUploadBoardData = success.data.posts
                DispatchQueue.main.async {
                    if success.data.posts.isEmpty {
                        completion(.failure)
                    } else {
                        completion(.success)
                    }
                }
            case .failure(let failure):
                print("### failure is \(failure)")
                DispatchQueue.main.async {
                    completion(.failure)
                }
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
    public func getMyCommentData(completion: @escaping ((_ returnType: ReturnType) -> ())) {
        APIServiceManager().request(with: getMyComment()) { result in
            switch result {
            case .success(let success):
                self.myCommentData = success.data.comments
                DispatchQueue.main.async {
                    if success.data.comments.isEmpty {
                        completion(.failure)
                    } else {
                        completion(.success)
                    }
                }
            case .failure(let failure):
                print("### failure is \(failure)")
                DispatchQueue.main.async {
                    completion(.failure)
                }
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
    
    // 로그아웃
    public func postLogoutData(completion: @escaping (() -> ())) {
        APIServiceManager().request(with: postLogout()) { result in
            switch result {
            case .success(let success):
                UserDefaults.standard.setValue(false, forKey: "isLogin")
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func postLogout() -> Endpoint<NullResponse> {
        let headers: [String: String] = [
            "X-STATION-ACCESS-TOKEN": ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        
        return Endpoint(
            path: "api/v1/logout",
            method: .post,
            headers: headers
        )
    }
    
    // 회원 탈퇴
    public func deleteUnregisterData(password: String, completion: @escaping ((_ returnType: ReturnType) -> ())) {
        APIServiceManager().request(with: deleteUnregister(password: password)) { result in
            switch result {
            case .success(let success):
                UserDefaults.standard.setValue(false, forKey: "isLogin")
                DispatchQueue.main.async {
                    completion(.success)
                }
            case .failure(let failure):
                print("### failure is \(failure)")
                DispatchQueue.main.async {
                    completion(.failure)
                }
            }
        }
    }
    
    private func deleteUnregister(password: String) -> Endpoint<NullResponse> {
        let headers: [String: String] = [
            "X-STATION-ACCESS-TOKEN": ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        
        return Endpoint(
            path: "api/v1/user",
            method: .delete,
            bodyParameters: UnregisterRequest(password: password),
            headers: headers
        )
    }
    
    struct UnregisterRequest: Encodable {
        let password: String
    }
    
}



