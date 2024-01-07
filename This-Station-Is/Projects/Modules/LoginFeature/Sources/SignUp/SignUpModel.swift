//
//  SignUpModel.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

public struct SignUpModel {
    static let shared = SignUpModel()
    
    var email: String = "" {
        didSet {
            print("### model is changed: \(self)")
        }
    }
    var authCode: String = "" {
        didSet {
            print("### model is changed: \(self)")
        }
    }
    var checkEmailEncrypt: String = "" {
        didSet {
            print("### model is changed: \(self)")
        }
    }
    var password: String = "" {
        didSet {
            print("### model is changed: \(self)")
        }
    }
    var passwordConfirm: String = "" {
        didSet {
            print("### model is changed: \(self)")
        }
    }
    var termsAgreementRequestList: [TermsAgreementRequest] = [] {
        didSet {
            print("### model is changed: \(self)")
        }
    }
    
    init() {}
}

public struct TermsAgreementRequest: Encodable {
    let terms: String
    let agreed: Bool
}
