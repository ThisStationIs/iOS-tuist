//
//  InputEmailViewModel.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation
import Network

enum IsValidEmail {
    case isValid
    case isNotValid
    case isUsed
}

class SignUpViewModel {
    var model: SignUpModel = SignUpModel.shared
    static let shared = SignUpViewModel()
    
    init() {}
    
//    func isValidEmail(input: String) -> IsValidEmail {
    func isValidEmail(input: String, completion: @escaping ((IsValidEmail) -> Void)) {
        guard isValidEmailRex(input: input) else {
            completion(.isNotValid)
            return
        }
//        guard isUsedEmail(input: input) else { return .isUsed }
        postDuplicatedEmail(input) { isDuplicated in
            if isDuplicated { completion(.isUsed) }
        }
        completion(.isValid)
    }
    
    private func isValidEmailRex(input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: input)
    }
    
    private func isUsedEmail(input: String) -> Bool {
        postDuplicatedEmail(input) { result in
            result
        }
        
        return true
    }
    
    func isValidNumber(input: String) -> Bool {
        
        return true
    }
}

extension SignUpViewModel {
    func postDuplicatedEmail(_ input: String, completion: @escaping ((Bool) -> Void)) {
        let endpoint = Endpoint<ResponseWrapper<DuplicatedEmailResponse>>(
            path: "api/v1/user/check/duplicated/email",
            method: .post,
            bodyParameters: DuplicatedEmailRequest(email: input)
        )
        
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                completion(success.data.isDuplicated)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    struct DuplicatedEmailRequest: Encodable {
        let email: String
    }
    
    struct DuplicatedEmailResponse: Decodable {
        let isDuplicated: Bool
    }
    
    func getTerms() {
        
    }
    
    func postCertNumber(
        email: String,
        certDivisionCode: String = "SIGN_UP"
    ) {
        
    }
    
    struct CertNumberResponse {
        let sendEmailEncrypt: String
    }
}

// MARK: - about find password
extension SignUpViewModel {
    func postFindPassword(
        email: String,
        certDivisionCode: String = "FIND_PASSWORD"
    ) -> Endpoint<ResponseWrapper<FindPasswordResponse>> {
        /// 입력한 이메일에 비밀번호 찾기 이메일 전송 api
        return Endpoint(
            path: "api/v1/user/find/password",
            method: .post,
            bodyParameters: FindPasswordBody(email: email, certDivisionCode: certDivisionCode)
        )
    }
    
    struct FindPasswordBody: Encodable {
        let email: String
        let certDivisionCode: String
    }
    
    struct FindPasswordResponse: Decodable {
        let sendEmailEncrypt: String
    }
}
