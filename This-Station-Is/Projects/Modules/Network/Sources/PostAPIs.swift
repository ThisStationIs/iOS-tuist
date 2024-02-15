//
//  PostAPIs.swift
//  Network
//
//  Created by Muzlive_Player on 2024/01/17.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import Foundation

public class PostAPIs {
    public static func getDetailBoard(id: Int) -> Endpoint<ResponseWrapper<DetailPost>> {
        return Endpoint(
            path: "api/v1/post/\(id)",
            method: .post
        )
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

}
