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
    public func getHomeRecentPosts() -> Endpoint<ResponseWrapper<RecentPosts>> {
        return Endpoint(
            path: "api/v1/home/recent/posts?size=5"
        )
    }
}

public struct ResponseWrapper<Response: Decodable>: Decodable {
    public let code: String
    public let message: String
    public let data: Response
    
    private enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
}


struct RecentPosts: Decodable {
    let posts: [Posts]
    private enum CodingKeys: String, CodingKey {
        case posts
    }
}

struct Posts: Decodable {
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
