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
    
    func isValidEmail(input: String) -> IsValidEmail {
        guard isValidEmailRex(input: input) else { return .isNotValid }
        guard isUsedEmail(input: input) else { return .isUsed }
        return .isValid
    }
    
    private func isValidEmailRex(input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: input)
    }
    
    private func isUsedEmail(input: String) -> Bool {
        return true
    }
}

extension SignUpViewModel {
    func getTerms() {
        
    }
}
