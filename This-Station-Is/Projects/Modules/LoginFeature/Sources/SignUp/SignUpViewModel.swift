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
    
    func getTerms(_ terms: String, completion: @escaping((String) -> Void)) {
        let endpoint = Endpoint<ResponseWrapper<TermsResponse>>(
            path: "api/v1/term/\(terms)"
        )
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                completion(success.data.downloadableUrl)
            case .failure(let failure):
                completion("")
            }
        }
    }
    
    struct TermsResponse: Decodable {
        let downloadableUrl: String
    }
    
    func postCertNumber(input: String, completion: @escaping((CertNumberResponse) -> Void)) {
        let endpoint = Endpoint<ResponseWrapper<CertNumberResponse>> (
            path: "api/v1/user/send/email/cert/number",
            method: .post,
            bodyParameters: CertNumberRequest(email: input)
        )
        
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                completion(success.data)
            case .failure(let failure):
                print("### postCertNumber is failed :\(failure)")
            }
        }
    }
    
    struct CertNumberRequest: Encodable {
        let email: String
        let certDivisionCode: String = "SIGN_UP"
    }
    
    struct CertNumberResponse: Decodable {
        let sendEmailEncrypt: String
        let sendCount: Int
    }
    
    func postCheckCertNumber(_ request: CheckCertNumberRequest, completion: @escaping ((String) -> Void)) {
        let endpoint = Endpoint<ResponseWrapper<CheckCertNumberResponse>> (
            path: "api/v1/user/check/email/cert/number",
            method: .post,
            bodyParameters: request
        )
        
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                completion(success.data.checkEmailEncrypt)
            case .failure(let failure):
                completion("failed")
                print("### postCheckCertNumber is failed :\(failure)")
            }
        }
    }
    
    struct CheckCertNumberRequest: Encodable {
        let email: String
        let authCode: String
        let sendEmailEncrypt: String
        let certDivisionCode: String = "SIGN_UP"
    }
    
    struct CheckCertNumberResponse: Decodable {
        let checkEmailEncrypt: String
    }
    
    func postSignUp(completion: @escaping (() -> Void)) {
        let endpoint = Endpoint<ResponseWrapper<SignUpResponse>> (
            path: "api/v1/user/sign/up",
            method: .post,
            bodyParameters: SignUpRequest(
                email: model.email,
                authCode: model.authCode,
                checkEmailEncrypt: model.checkEmailEncrypt,
                password: model.password,
                passwordConfirm: model.passwordConfirm,
                termsAgreementRequestList: model.termsAgreementRequestList)
        )
        
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                print("### success is \(success)")
                completion()
            case .failure(let failure):
                print("### postSignUp is failed :\(failure)")
            }
        }
    }
    
    struct SignUpRequest: Encodable {
        let email: String
        let authCode: String
        let checkEmailEncrypt: String
        let password: String
        let passwordConfirm: String
        let termsAgreementRequestList: [TermsAgreementRequest]
    }
    
    struct SignUpResponse: Decodable {
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
