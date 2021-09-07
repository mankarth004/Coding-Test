//
//  SearchFieldValidationTests.swift
//  GitReposSampleTests
//
//  Created by Blue Peak Systems on 9/7/21.
//

import XCTest
@testable import GitReposSample

class SearchFieldValidationTests: XCTestCase {
    
    func test_SearchField_MinLength_returns_error() {
        //        ARRANGE
        let query = "swi"
        //        ACT
        let result = RegexValidator.validate(query)
        //        ASSERT
        XCTAssertNotNil(result)
        XCTAssertEqual(result, ValidationMessage.enterMinCharacters)
    }
    func test_SearchField_MaxLength_returns_error() {
        //        ARRANGE
        let query = "swisjsadjlaskdjsahkjhkjsahdkjashdkjahsjkdhakshdjkashjkdhasjkdhjksahdjksahkdjjsahdkjhasjdhjsahdkjhaskjdhsajdkjashd"
        //        ACT
        let result = RegexValidator.validate(query)
        //        ASSERT
        XCTAssertNotNil(result)
        XCTAssertEqual(result, ValidationMessage.maxCharactersReached)
    }
    func test_SearchField_AlphaNumeric_returns_error() {
        //        ARRANGE
        let query = "😀😅😆😃😄🙌"
        //        ACT
        let result = RegexValidator.validate(query)
        //        ASSERT
        XCTAssertNotNil(result)
        XCTAssertEqual(result, ValidationMessage.enterAlphaNumeric)
    }
    func test_SearchField_SpecialChars_Mixed_returns_error() {
        //        ARRANGE
        let query = "swif#@$"
        //        ACT
        let result = RegexValidator.validate(query)
        //        ASSERT
        XCTAssertNotNil(result)
        XCTAssertEqual(result, ValidationMessage.enterAlphaNumeric)
    }
    func test_SearchField_vaid_returns_success() {
        //        ARRANGE
        let query = "swift"
        //        ACT
        let result = RegexValidator.validate(query)
        //        ASSERT
        XCTAssertNil(result)
    }
    
}
