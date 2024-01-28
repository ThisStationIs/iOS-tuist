//
//  LoginUtil.swift
//  CommonProtocol
//
//  Created by 심효주 on 1/29/24.
//  Copyright © 2024 Kkonmo. All rights reserved.
//

import Foundation

public func setUserData(
    _ userId: Int,
    _ nickName: String,
    _ at: String,
    _ rt: String
) {
    UserDefaults.standard.setValue(userId, forKey: "userId")
    UserDefaults.standard.setValue(nickName, forKey: "nickName")
    UserDefaults.standard.setValue(at, forKey: "accessToken")
    UserDefaults.standard.setValue(rt, forKey: "refreshToken")
}

public func isValidAccessToken() -> Bool {
    guard let at = UserDefaults.standard.string(forKey: "accessToken") else {
        return false
    }
    return true
}
