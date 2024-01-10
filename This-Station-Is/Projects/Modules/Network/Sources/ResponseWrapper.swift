//
//  ResponseWrapper.swift
//  Network
//
//  Created by Muzlive_Player on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

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

public struct NullResponse: Decodable {
    let code: String
    let message: String
    let data: String?
}
