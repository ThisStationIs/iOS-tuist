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
    /*
     "commentId": 0,
          "postId": 0,
          "postTitle": "string",
          "content": "string",
          "isBlocked": true,
          "likeCount": 0,
          "createdAt": "2024-01-06T18:25:25.961Z",
          "lastUpdatedAt": "2024-01-06T18:25:25.961Z"
     */
    let commentId: Int
    let postId: Int
    let postTitle: String
    let content: String
    let isBlocked: Bool
    let likeCount: Int
    let createdAt: String
    let lastUpdatedAt: String
}

public struct NullResponse: Decodable {
    let code: String
    let message: String
    let data: String?
}
