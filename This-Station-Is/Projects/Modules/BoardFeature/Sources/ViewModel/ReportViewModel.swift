//
//  ReportViewModel.swift
//  BoardFeature
//
//  Created by min on 2024/01/07.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import Foundation
import Network
import CommonProtocol

public class ReportViewModel: NSObject {
    var reasonData: [ReportReason] = []
    
    //"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwidXNlcklkIjoxLCJpc3N1ZWRBdCI6IjIwMjMtMTItMjggMDI6MzY6MDQiLCJleHBpcmF0aW9uQXQiOiIyMDIzLTEyLTI5IDAyOjM2OjA0In0.emd0bOvM077ExVd4XdqrfkPhhlcKCSoupzAYSdwEbPqPOJOavYBFTc1I6dqGcdMo5UQTah-NFjhcZ241pXvX8g"
    var ACCESS_TOKEN: String = UserDefaults.standard.string(forKey: "accessToken") ?? ""
    
    // 신고 사유
    public func getReportReasonData(completion: @escaping (() -> ())) {
        APIServiceManager().request(with: getReportReason()) { result in
            switch result {
            case .success(let success):
                print(success)
                self.reasonData = success.data.reportReasons
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getReportReason() -> Endpoint<ResponseWrapper<ReportReasonsData>> {
        return Endpoint(
            path: "api/v1/report/reasons"
        )
    }
    
    // 게시글 신고
    // /api/v1/post/{postId}/report/{reportReasonId}
    public func postReportData(postId: Int, reportReasonId: Int, completion: @escaping (() -> ())) {
        APIServiceManager().request(with: postReport(postId: postId, reportReasonId: reportReasonId)) { result in
            switch result {
            case .success(let success):
                print(success)
                self.reasonData = success.data.reportReasons
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func postReport(postId: Int, reportReasonId: Int) -> Endpoint<ResponseWrapper<ReportReasonsData>> {
        let headers: [String: String] = [
            "X-STATION-ACCESS-TOKEN": ACCESS_TOKEN,
            "Content-Type": "application/json"
        ]
        
        return Endpoint(
            path: "api/v1/post/\(postId)/report/\(reportReasonId)",
            headers: headers
        )
    }
}
