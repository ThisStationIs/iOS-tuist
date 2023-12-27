//
//  SubwayLine.swift
//  BoardFeature
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

struct SubwayLineData: Decodable {
    let code: String
    let message: String
    let data: LinesData
}

struct LinesData: Decodable {
    let lines: [Lines]
}

public struct Lines: Decodable {
    let id: Int
    let name: String
    let colorCode: String
}
    
