//
//  RegexValidator.swift
//  GitReposSample
//
//  Created by Blue Peak Systems on 9/7/21.
//

import Foundation
class RegexValidator {
    static func validate(_ string: String) -> String? {
        if !NSPredicate(format: "SELF MATCHES %@", Regex.minLength).evaluate(with: string) {
            return ValidationMessage.enterMinCharacters
        }
        if !NSPredicate(format: "SELF MATCHES %@", Regex.maxLenth).evaluate(with: string) {
            return ValidationMessage.maxCharactersReached
        }
        if !NSPredicate(format: "SELF MATCHES %@", Regex.alphaNumeric).evaluate(with: string) {
            return ValidationMessage.enterAlphaNumeric
        }
        return nil
    }
}
