//
//  Comment.swift
//  BoardFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

public struct CommentData: Decodable {
    /*
     {
       "code": "200",
       "message": "OK",
       "data": {
         "postId": 2,
         "comments": [
           {
             "commentId": 2,
             "postId": 2,
             "content": "네ㅠㅠ 자문자답ㅎ",
             "authorNickname": "밝은고양이",
             "isDeleted": false,
             "isBlocked": false,
             "likeCount": 0,
             "lastUpdatedAt": "2023-12-27T03:43:17"
           },
           {
             "commentId": 1,
             "postId": 2,
             "content": "분실물센터 확인해보셨나요?",
             "authorNickname": "밝은고양이",
             "isDeleted": false,
             "isBlocked": false,
             "likeCount": 0,
             "lastUpdatedAt": "2023-12-27T03:42:22"
           }
         ],
         "lastCommentId": null,
         "hasMoreComments": false
       }
     }
     */
    
    let postId: Int
    let comments: [Comments]
    let lastCommentId: Int?
    let hasMoreComments: Bool
}

public struct Comments: Decodable {
    /*
     {
       "commentId": 2,
       "postId": 2,
       "content": "네ㅠㅠ 자문자답ㅎ",
       "authorNickname": "밝은고양이",
       "isDeleted": false,
       "isBlocked": false,
       "likeCount": 0,
       "lastUpdatedAt": "2023-12-27T03:43:17"
     },
     */
    let commentId: Int
    let postId: Int
    let content: String
    let authorNickname: String
    let isDeleted: Bool
    let isBlocked: Bool
    let likeCount: Int
    let lastUpdatedAt: String
}

public struct UploadCommentData: Encodable {
    var content: String
}

struct UploadCommentResponse: Decodable {
    /*
     {
       "commentId": 0,
       "postId": 0,
       "content": "string",
       "authorNickname": "string",
       "isReported": true,
       "likeCount": 0,
       "createdAt": "2024-02-08T14:00:15.147Z",
       "lastUpdatedAt": "2024-02-08T14:00:15.148Z"
     }
     */
    let commentId: Int
    let postId: Int
    let content: String
    let authorNickname: String
    let isReported: Bool
    let likeCount: Int
    let createdAt: String
    let lastUpdatedAt: String
}
