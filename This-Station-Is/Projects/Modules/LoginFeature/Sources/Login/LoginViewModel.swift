//
//  LoginViewModel.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation
import Network

class LoginViewModel {
    init() {
        
    }
    
    func moveToJoinVC() {
        
    }
}

extension LoginViewModel {
    func postLogin(
        email: String,
        password: String
    ) -> Endpoint<ResponseWrapper<LoginResponse>>{
        return Endpoint(
            path: "api/v1/login",
            method: .post,
            bodyParameters: LoginRequest(email: email, password: password)
        )
    }

    struct LoginRequest: Encodable {
        let email: String
        let password: String
    }
    
    struct LoginResponse: Decodable {
        let nickName: String
        let accessToken: String
        let refreshToken: String

        private enum CodingKeys: String, CodingKey {
            case nickName = "nickname"
            case accessToken
            case refreshToken
        }
    }
}


