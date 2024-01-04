//
//  InputPasswordViewModel.swift
//  LoginFeature
//
//  Created by Muzlive_Player on 2023/12/26.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation

enum IsValidPassword {
    case isEnglish
    case isCount
    case isValid
}

class InputPasswordViewModel {
    var isValidCount: Int = 0 {
        didSet {
            print(self.isValidCount)
        }
    }
    
    func isValidPassword(
        firstInput: String,
        secondInput: String
    ) -> Bool {
        guard isValidEnglish(input: firstInput) else { return false }
        guard isValidCount(input: firstInput) else { return false }
        guard isCorrect(firstInput: firstInput, secondInput: secondInput) else { return false }
        return true
    }
    
    func isValidEnglish(input: String) -> Bool {
        if input.contains(where: { $0.isLowercase }) && input.contains(where: { $0.isUppercase }) {
            return true
        }
        return false
    }
    
    func isValidCount(input: String) -> Bool {
        if 8...16 ~= input.count ? true : false {
            return true
        }
        return false
    }
    
    func isCorrect(
        firstInput: String,
        secondInput: String
    ) -> Bool {
        if firstInput == secondInput ? true : false {
            return true
        }
        return false
    }
}
