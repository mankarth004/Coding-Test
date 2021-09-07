//
//  Constants.swift
//  GitReposSample
//
//  Created by Blue Peak Systems on 9/7/21.
//

import Foundation
struct Constants {
    static let searchMinLength = 4
    static let searchMaxLength = 30
    static let perPageResults = 20
}
struct Regex {
    static let minLength = "^.{\(Constants.searchMinLength),}$"
    static let maxLenth = "^.{4,\(Constants.searchMaxLength)}$"
    static let alphaNumeric = "^[ a-zA-Z0-9_./-]*$"
}
struct ValidationMessage {
    static let enterMinCharacters = "Please enter \(Constants.searchMinLength) or more characters"
    static let maxCharactersReached = "Please enter upto \(Constants.searchMaxLength) characters"
    static let enterAlphaNumeric = "Please enter only alpha numeric characters\nAllowed special characters are _, -, / and ."
}
