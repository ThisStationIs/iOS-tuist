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
    
    let ACCESS_TOKEN = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXNlcklkIjoxLCJpc3N1ZWRBdCI6IjIwMjMtMTItMjggMDE6NTU6MTciLCJleHBpcmF0aW9uQXQiOiIyMDIzLTEyLTI4IDAxOjU1OjE3In0.oSfKvYL1kzqcl4MToHCuVa7n0PcTBtCCTowowa6QFwPjYuLMrt_sv6z6OHBcBq61QizCl8Fp4bgMuuK2UeRGhg"
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
}
