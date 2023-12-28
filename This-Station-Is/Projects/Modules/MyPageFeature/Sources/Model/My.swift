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

public struct MyCommentData: Decodable {
    let comments: [Comments]
    let lastCommentId: Int?
    let hasMoreComments: Bool
}

public struct Comments: Decodable {
    let commentId: Int
    let postId: Int
    let content: String
    let authorNickname: String
    let isDeleted: Bool
    let isBlocked: Bool
    let likeCount: Int
    let createdAt: String
    let lastUpdatedAt: String
}
