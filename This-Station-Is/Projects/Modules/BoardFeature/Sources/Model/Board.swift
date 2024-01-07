//
//  Board.swift
//  BoardFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

/*
 {
   "posts": [
     {
       "postId": 0,
       "authorNickname": "string",
       "subwayLineName": "string",
       "categoryName": "string",
       "title": "string",
       "preview": "string",
       "commentCount": 0,
       "likeCount": 0,
       "isReported": true,
       "createdAt": "2023-12-27T19:13:19.002Z"
     }
   ],
   "lastPostId": 0,
   "hasMorePost": true
 }
 */

struct BoardModel<T: Decodable>: Decodable {
    let code: String
    let message: String
    let data: T
}

struct BoardData: Decodable {
    let posts: [Post]
    let lastPostId: Int?
    let hasMorePost: Bool
}

public struct Post: Decodable {
    let postId: Int
    let userId: Int
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

public struct DetailPost: Decodable {
    /*
     "postId": 1,
         "authorNickname": "밝은고양이",
         "subwayLineId": 1,
         "subwayLineName": "1호선",
         "categoryId": 1,
         "categoryName": "연착정보",
         "title": "테스트 제목이에용~",
         "content": "테스트 내용이에용!",
         "commentCount": 0,
         "likeCount": 0,
         "comments": [],
         "hasMoreComment": false,
         "lastCommentId": null,
         "createdAt": "2023-12-27T03:38:34",
         "lastUpdatedAt": "2023-12-27T03:38:34"
     */
    let postId: Int
    let userId: Int
    let authorNickname: String
    let subwayLineId: Int
    let subwayLineName: String
    let categoryId: Int
    let categoryName: String
    let title: String
    let content: String
    let commentCount: Int
    let likeCount: Int
    let comments: [Comment]
    let hasMoreComment: Bool
    let lastCommentId: Int?
    let createdAt: String
    let lastUpdatedAt: String
}

struct Comment: Decodable {
    let commentId: Int
    let userId: Int
    let nickname: String
    let content: String
    let isReported: Bool
    let createdAt: String
    let lastUpdatedAt: String
}

public struct UploadBoardData: Encodable {
    /*
     {
       "categoryId": 0,
       "subwayLineId": 0,
       "title": "string",
       "content": "string"
     }
     */
    
    var categoryId: Int
    var subwayLineId: Int
    var title: String
    var content: String
}

struct UploadBoardResponse: Decodable {
    /*
     {
       "code": "200",
       "message": "OK",
       "data": {
         "postId": 3,
         "authorNickname": "밝은고양이",
         "title": "타이틀",
         "content": "컨텐츠",
         "createdAt": "2023-12-28T05:18:21.810140476"
       }
     }
     */
    
    let postId: Int
    let authorNickname: String
    let title: String
    let content: String
    let createdAt: String
}

