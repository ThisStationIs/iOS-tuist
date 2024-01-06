//
//  Report.swift
//  BoardFeature
//
//  Created by min on 2024/01/07.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import Foundation

/*
 "reportReasons": [
       {
         "id": 1,
         "name": "SAME_POST",
         "description": "도배 글"
       },
 */
struct ReportReasonsData: Decodable {
    let reportReasons: [ReportReason]
}

struct ReportReason: Decodable {
    let id: Int
    let name: String
    let description: String
}
