//
//  SignUpModel.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

public struct SignUpModel {
    let email: String
    let authCode: String = "SIGN_UP"
    let checkEmailEncrypt: String
    let password: String
    let passwordConfirm: String
    let termsAgreementRequestList: [TermsAgreementRequest]
}

public struct TermsAgreementRequest {
    let terms: String
    let agreed: Bool
}
