//
//  My.swift
//  MyPageFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

public struct MyUploadBoardData: Decodable {
    let posts: [Post]
    let lastPostId: Int?
    let hasMorePost: Bool
}

public struct Post: Decodable {
    let postId: Int
    let authorNickname: String
    let subwayLineName: String
    let categoryName: String
    let title: String
    let preview: String
    let commentCount: Int
    let likeCount: Int
    let isReported: Bool
    let createdAt: String
}
