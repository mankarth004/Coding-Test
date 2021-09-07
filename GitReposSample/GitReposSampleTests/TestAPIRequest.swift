//
//  TestAPIRequest.swift
//  GitReposSampleTests
//
//  Created by Blue Peak Systems on 9/7/21.
//

import XCTest
@testable import GitReposSample

class TestAPIs: XCTestCase {
    func testAPICall() {
//        ARRANGE
        let viewModel = RepoSearchResultViewModel()
        let expectations = expectation(description: "GitRepoAPI_Valid_Request_Returns_Success")
//        ACT
        viewModel.fetchRepositories("Swift", pageNo: 1) { (repoSearchResult) in
//            ASSERT
            XCTAssertNotNil(repoSearchResult)
            XCTAssertNotNil(repoSearchResult?.items)
            expectations.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    func test_OptionalBinding_invalid_returns_error() {
//        ACT
        let result = MockExtensions().getUnwrappedValue(nil)
//        ASSERT
        XCTAssertNotNil(result)
        XCTAssertEqual(result, "")
    }
    func test_OptionalBinding_valid_returns_success() {
//        ARRANGE
        let urlString: String? = "http://google.com"
//        ACT
        let result = MockExtensions().getUnwrappedValue(urlString)
//        ASSERT
        XCTAssertNotNil(result)
        XCTAssertEqual(result, urlString)
    }
}

class MockExtensions {
    func getUnwrappedValue(_ string: String?) -> String {
        return string.defaultUnwrapped
    }
}
