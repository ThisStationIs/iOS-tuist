//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by Muzlive_Player on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation
import Network

class HomeViewModel {
    var lineInfo: [Lines] = []
    
    public func getHomeRecentPosts() -> Endpoint<ResponseWrapper<RecentPosts>> {
        return Endpoint(
            path: "api/v1/home/recent/posts?size=5"
        )
    }
    
    public func getHomeHotPosts() -> Endpoint<ResponseWrapper<RecentPosts>> {
        return Endpoint(
            path: "api/v1/home/hot/posts?size=5"
        )
    }
    
    public func getSubwayLine(completion: @escaping (([Lines]) -> ())) {
        // /api/v1/subway/lines
        APIServiceManager().request(with: getLine()) { result in
            switch result {
            case .success(let success):
                self.lineInfo = success.data.lines
                print("### line info is \(success.data)")
                DispatchQueue.main.async {
                    completion(success.data.lines)
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
    
    struct SubwayLineModel: Decodable {
        let code: String
        let message: String
        let data: LinesData
    }

    struct LinesData: Decodable {
        let lines: [Lines]
    }

}

public struct Lines: Decodable {
    let id: Int
    let name: String
    let colorCode: String
}

struct RecentPosts: Decodable {
    let posts: [Post]
    private enum CodingKeys: String, CodingKey {
        case posts
    }
}

struct Post: Decodable {
    let postId: Int
    let authorNickname: String
    let subwayLineName: String
    let categoryName: String
    let title: String
    let preview: String
    let commentCount: Int
    let likeCount: Int
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case postId
        case authorNickname
        case subwayLineName
        case categoryName
        case title
        case preview
        case commentCount
        case likeCount
        case createdAt
    }
}
