//
//  NetworkError.swift
//  Network
//
//  Created by Muzlive_Player on 2023/12/15.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case common
    
    case noResponse
    case noData
    
    case statusCodeError
    case decodeError
    case requestError
    case urlError
}
