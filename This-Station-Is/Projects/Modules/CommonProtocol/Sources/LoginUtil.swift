//
//  LoginUtil.swift
//  CommonProtocol
//
//  Created by 심효주 on 1/29/24.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import Foundation

public func isValidAccessToken() -> Bool {
    guard let at = UserDefaults.standard.string(forKey: "accessToken") else {
        return false
    }
    return true
}
