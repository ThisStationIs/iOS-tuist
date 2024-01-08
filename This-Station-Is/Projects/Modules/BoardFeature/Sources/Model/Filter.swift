//
//  Filter.swift
//  BoardFeature
//
//  Created by min on 2024/01/07.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import Foundation

/*
 "data": {
    "posts": [
      {
        "postId": 12,
        "authorNickname": "밝은고양이",
        "subwayLineName": "3호선",
        "categoryName": "연착정보",
        "title": "",
        "preview": "",
        "commentCount": 0,
        "likeCount": 0,
        "isReported": false,
        "createdAt": "2023.12.29 01:47:49"
      }
    ],
 */

struct FilterPostsData: Decodable {
    let posts: [Post]
    let totalPages: Int?
    let hasMorePost: Bool
}
